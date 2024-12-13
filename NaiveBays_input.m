function NaiveBays_input()
    load('dados_treino.mat', 'dados_treino');
    load('rotulos_treino.mat', 'rotulos_treino');
    load('ultima_palavra_teste.mat', 'senha');

    prob_segura = sum(rotulos_treino == 1) / length(rotulos_treino);
    prob_nao_segura = 1 - prob_segura;

    num_dados = size(dados_treino, 2);
    prob_passe_dado_seguro = (sum(dados_treino(rotulos_treino == 1, :)) + 1) ./ ...
        (sum(rotulos_treino == 1) + num_dados);
    prob_passe_dado_nao_seguro = (sum(dados_treino(rotulos_treino == 0, :)) + 1) ./ ...
        (sum(rotulos_treino == 0) + num_dados);

    dados_senha = dados_passe(senha);

    probabilidade_ser_segura = log(prob_segura) + sum(dados_senha .* log(prob_passe_dado_seguro));
    probabilidade_nao_segura = log(prob_nao_segura) + sum(dados_senha .* log(prob_passe_dado_nao_seguro));

    if probabilidade_ser_segura > probabilidade_nao_segura
        fprintf('Naive Bayes: A palavra-passe "%s" é classificada como segura.\n', senha);
    else
        fprintf('Naive Bayes: A palavra-passe "%s" é classificada como não segura.\n', senha);
    end
end
