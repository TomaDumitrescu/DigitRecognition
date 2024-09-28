## Copyright (C) 2023 Andrei
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} task2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2023-02-28

function new_X = task2 (photo, pcs)
  [m n] = size (photo);

  % initializare matrice finala
  new_X = zeros (m, n);

  % cast photo la double
  photo = double (photo);

  % normalizeaza matricea initiala scazand din ea media fiecarui rand.
  q = zeros (m, 1);
  q = double (q);
  for i = 1:m
    q(i) = sum(photo(i, 1:n));
    q(i) /= n;
    photo(i, 1:n) -= q(i);
  endfor

  % construire Z
  Z = zeros (n, m);
  Z = double (Z);
  photo = photo';

  % verificam daca se poate imparti la n - 1
  if n == 1
    return;
  endif

  Z = (1 / (sqrt(n - 1))) * photo;

  % calculare matrici U, S si V din SVD aplicat matricii Z
  [u, s, v] = svd (Z);

  % construire W din primele pcs coloane ale lui V
  photo = photo';
  [m1, n1] = size (v);

  % extragerea submatricei corespunzatoare
  Vk = v([1:m1], [1:pcs]);

  W = Vk;
  W = W';

  % calcularea matricei Y
  Y = W * photo;
  % aproximarea matricei initiale
  new_X = (W') * Y;
  [m, n] = size (new_X);
  for i = 1:m
	new_X(i, 1:n) += q(i);
  endfor

  % transforma matricea in uint8 pentru a fi o imagine valida
  new_X = uint8 (new_X);

endfunction