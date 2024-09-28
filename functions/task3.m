## Copyright (C) 2021 Andrei
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
## @deftypefn {} {@var{retval} =} pca_cov (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-06

function new_X = task3 (photo, pcs)
  [m, n] = size (photo);

  % initializare matrice finala.
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

  % se calculeaza matricea de covarianta.
  Z = photo * (photo');
  Z = Z * (1 / (n - 1));

  % se calculeaza vectorii si valorile proprii ale matricei de covarianta.
  % HINT: functia eig
  [V S] = eig (Z);

  % se ordoneaza descrescator valorile proprii si creaza o matrice V
  % formata din vectorii proprii asezati pe coloane, astfel incat prima coloana
  % sa fie vectorul propriu corespunzator celei mai mari valori proprii si
  % asa mai departe.
  eig_V = zeros (m, 1);
  col_idx = zeros (m, 1);
  for i = 1:m
    eig_V(i) = S(i, i);
  endfor
  [~, ind] = sort(eig_V, "descend");

  % se pastreaza doar primele pcs coloane
  for j = 1:pcs
    W(1:m, j) = V(1:m, ind(j));
  endfor

  % OBS: primele coloane din V reprezinta componentele principale si
  % pastrandu-le doar pe cele mai importante obtinem astfel o compresie buna
  % a datelor. Cu cat crestem numarul de componente principale claritatea
  % imaginii creste, dar de la un numar incolo diferenta nu poate fi sesizata
  % de ochiul uman asa ca pot fi eliminate.

  % se creeaza matricea Y schimband baza matricii initiale
  Y = (W') * photo;

  % se calculeaza matricea new_X care este o aproximatie a matricii initiale
  new_X = W * Y;
  % se aduna media randurilor scazuta anterior
  for i = 1:m
    new_X(i, 1:n) += q(i);
  endfor

  % se transforma matricea in uint8 pentru a fi o imagine valida
  new_X = uint8 (new_X);
endfunction