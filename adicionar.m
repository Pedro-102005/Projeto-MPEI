function BF = adicionar(BF, elemento, k)
    for i = 1:k
        elemento_modificado = [elemento num2str(i^2*10001)];
        indice = mod(string2hash(elemento_modificado), length(BF)) + 1;
        BF(indice) = 1;
    end
end