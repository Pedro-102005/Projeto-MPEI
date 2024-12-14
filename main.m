load('BF.mat');
p = 0.001;  
m = length(BF);
n = round(-(m * log(p) / (log(2))^2));
k = round(((n / m) * log(2)) + 1);


senha = input('Digite uma palavra-passe para verificar: ', 's');
save('ultima_palavra_teste.mat', 'senha'); % Salvar senha para uso nas funções

NaiveBays_input(senha);

load('naive_bayes_result.mat', 'is_segura');

if is_segura
    is_compromised = check(BF, senha, k);
    if is_compromised
        fprintf('Filtro de Bloom: A palavra-passe "%s" está comprometida.\n', senha);
        Minhash_input(senha);
    else
        fprintf('Filtro de Bloom: A palavra-passe "%s" não está comprometida.\n', senha);
        Minhash_input(senha);
    end
else
    fprintf('A palavra-passe "%s" é classificada como não segura. Encerrando a verificação.\n', senha);
end
