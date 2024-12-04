function dados = dados_passe(password)
    tamanho = length(password) > 8;
    numeros = sum(isstrprop(password, 'digit')) >= 1;
    maiusculas = sum(isstrprop(password, 'upper')) >= 1;
    simbolos = sum(~(isstrprop(password, 'alpha') | isstrprop(password, 'digit'))) >= 1;
    repetidos = max(diff(find([1, diff(double(password)) ~= 0, 1]))) >= 3;
    dados= [tamanho, numeros, maiusculas, simbolos, repetidos];
end
