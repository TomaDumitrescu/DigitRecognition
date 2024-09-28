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
## @deftypefn {} {@var{retval} =} magic_with_pca (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-08

function [train, miu, Y, Vk] = magic_with_pca (train_mat, pcs)
  [m, n] = size (train_mat);

  % initializare train
  train = zeros (m, n);

  % initializare miu
  miu = zeros (1, n);

  % initializare Y
  Y = zeros (m, pcs);

  % initializare Vk
  Vk = zeros (n, pcs);

  % cast train_mat la double.
  train_mat = double(train_mat);

  % se calculeaza media fiecarei coloane a matricii.
  for i = 1:n
    miu(i) = sum(train_mat(1:m, i));
  endfor
	miu(1:n) = miu(1:n) / m;

  % se scade media din matricea initiala.
  for i = 1:n
    train_mat(1:m, i) -= miu(i);
  endfor

  % se calculeaza matricea de covarianta.
  if m == 1
    return;
  endif
  cov_matrix = ((train_mat') * train_mat) * (1 / (m - 1));

  % se calculeaza vectorii si valorile proprii ale matricei de covarianta.
  % HINT: functia eig
  [V, S] = eig(cov_matrix);

  % se ordoneaza descrescator valorile proprii si creaza o matrice V
  % formata din vectorii proprii asezati pe coloane, astfel incat prima coloana
  % sa fie vectorul propriu corespunzator celei mai mari valori proprii si
  % asa mai departe.
  eig_V = zeros(1, n);
  for i = 1:n
    eig_V(1, i) = S(i, i);
  endfor
  [~, ind] = sort(eig_V, "descend");

  % se pastreaza doar primele pcs coloane din matricea obtinuta anterior.
  for i = 1:pcs
    Vk(1:n, i) = V(1:n, ind(i));
  endfor

  % se creeaza matricea Y schimband baza matricii initiale.
  Y = train_mat * Vk;

  % se calculeaza matricea train care este o aproximatie a matricii initiale
  % folosindu-va de matricea Vk calculata anterior
  train = Y * (Vk');
endfunction