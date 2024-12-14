function [BF, hashrepetido] = adicionar(BF, elemento, k)
    hashrepetido = 0;
    for i = 1:k
        elemento_modificado = [elemento num2str(i^2*10001)];
        indice = mod(string2hash(elemento_modificado), length(BF)) + 1;
        if BF(indice) == 1
            hashrepetido = hashrepetido + 1;
        end
        BF(indice) = 1;
    end
end