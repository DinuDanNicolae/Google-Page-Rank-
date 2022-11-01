function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si care calculeaza valoarea functiei membru in punctul x.
	% Stim ca 0 <= x <= 1
 
%valorile a si b pentru ca functia sa fie continua  
b = 1-1/(1-val1/val2);
a = -b/val1;

%afla y in functie de ramura pe care ne aflam 
if(x < val1 && x >= 0)
  y = 0;
endif

if(x >= val1 && x <= val2)
  y = a * x + b;
endif

if(x > val2 && x <= 1)
  y = 1;
endif

endfunction