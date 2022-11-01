function R = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
  
output_precision(7)

File = fopen(nume, "r");
N = fgetl(File); %citim din fisier numarul de noduri de pe prima linie
N = str2num(N); %convertim caracterele stocate in numere

%formam matricea de adiacenta
aux = fgetl(File); 
aux = str2num(aux);
L = [aux(2)]; %stocam in vector numarul de legaturi
limit = aux(2) + 2; %limit va retine numarul de noduri de pe o linie
for j = 3:limit %parcurgem pe coloana nodurile 
  A(1,aux(j)) = 1; %adaugam in matricea de adiacenta 1 la indicele respectiv
endfor
for i = 2:N
  aux = fgetl(File);
  aux = str2num(aux);
  L(end+1) = aux(2);
  limit = aux(2) + 2;
  for j = 3:limit
    A(i,aux(j)) = 1;
  endfor
endfor

L = L.'; %transpunem vectorul L

%egalam diagonala principala cu 0 si modificam vectorul cu numarul de legaturi daca e nevoie
for i = 1:N
  if A(i,i) == 1
    A(i,i) = 0;
    L(i) = L(i) - 1;
  endif
endfor

%formam matricea M dupa formula data
for i = 1:N
  for j = 1:N
    if A(j,i) == 1
      M(i,j) = 1/L(j);
    endif
  endfor
endfor

%disp(L);
%disp(A);
%disp(M);

vect_of_ones = ones(N,1);

value = 1/N;

R = ones(N,1);

R = value * R;

cpy = zeros(N,N);
while abs(norm(R - cpy)) > eps %verificam diferenta cu eroarea
  cpy = R; %retinem R-ul de la pasul trecut
  R = d * M * R + ((1-d)/N)*vect_of_ones; %formam R-ul la pasul urmator
endwhile

fclose(File);
endfunction
  
 
 