function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out

output_precision(7);
  
File = fopen(nume, "r");
N = fgetl(File); %citim din fisier numarul de noduri de pe prima linie
N = str2num(N); %convertim caracterele stocate in numere

for i = 1:N
  buffer = fgetl(File);
  buffer = str2num(buffer);
endfor

%citim din fisier valorile cerute
val1 = fgetl(File);
val1 = str2num(val1);

val2 = fgetl(File);
val2 = str2num(val2);
  
%disp(val1);
%disp(val2);

I = Iterative(nume, d, eps);
A = Algebraic(nume, d);

%aflam lungimea vectorului rezultat in urma apelului Algebraic
size = length(A);

%formam vectorul de "numerotare"
for i = 1:size
  vect_of_index(i) = i;
endfor;

%disp(vect_of_index);

%formam numele fisierului de iesire
str1 = nume;
str2 = '.out';
exit_file = [str1,str2];

fid = fopen(exit_file, "w");

%incepem scrierea in fisier
fprintf(fid,'%d\n',N);
fprintf(fid,'\n');

for i = 1:size
  fprintf(fid,'%d\n',I(i));
endfor
fprintf(fid,"\n");

for i = 1:size
  fprintf(fid,'%d\n',A(i));
endfor
fprintf(fid,'\n');

%sortam descrescator vectorul A si interschimbam indexul respectiv din vect_of_index
for i = 1:size
  for j = 1:size
    if A(j) < A(i)
      temp1 = A(i);
      A(i) = A(j);
      A(j) = temp1;
      temp2 = vect_of_index(i);
      vect_of_index(i) = vect_of_index(j);
      vect_of_index(j) = temp2;
    endif
  endfor
endfor

%disp(vect_of_index);
%disp(A);

for i = 1:size
  aux = Apartenenta(A(i),val1,val2);
  PR(i) = aux;
endfor;

%disp(PR);

for i = 1:size
  fprintf(fid,'%d ',i);
  fprintf(fid,'%d ',vect_of_index(i));
  fprintf(fid,'%d\n',PR(i));
endfor


fclose(fid);
fclose(File);
endfunction
