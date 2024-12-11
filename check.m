function boleano = check(BF, elemento, k)
    boleano = true; % Assumimos que é membro inicialmente
    for i = 1:k
        elemento_modificado = [elemento num2str(i^2*10001)];
        indice = mod(string2hash(elemento_modificado), length(BF)) + 1;
        if BF(indice) == 0
            boleano = false; % Se uma posição é zero, não é membro
            break;
        end
    end
end