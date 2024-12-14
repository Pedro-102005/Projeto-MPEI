function [precisao_seguras, precisao_nao_seguras] = NaiveBays()
    load('dados_treino.mat', 'dados_treino');
    load('rotulos_treino.mat', 'rotulos_treino');
    load('senhas_seguras_teste.mat', 'senhas_seguras_teste');
    load('senhas_nao_seguras_teste.mat', 'senhas_nao_seguras_teste');

    % Probabilidades a priori
    prob_segura = sum(rotulos_treino == 1) / length(rotulos_treino);
    prob_nao_segura = 1 - prob_segura;

    % Probabilidades condicionais 
    num_dados = size(dados_treino, 2);
    prob_passe_dado_seguro = (sum(dados_treino(rotulos_treino == 1, :)) + 1) ./ (sum(rotulos_treino == 1) + num_dados);
    prob_passe_dado_nao_seguro = (sum(dados_treino(rotulos_treino == 0, :)) + 1) ./ (sum(rotulos_treino == 0) + num_dados);

    previsoes_certas_seguras = 0;
    for i = 1:length(senhas_seguras_teste)
        senha = senhas_seguras_teste{i};
        dados_senha = dados_passe(senha);

        probabilidade_ser_segura = log(prob_segura) + sum(dados_senha .* log(prob_passe_dado_seguro));
        probabilidade_nao_segura = log(prob_nao_segura) + sum(dados_senha .* log(prob_passe_dado_nao_seguro));

        if probabilidade_ser_segura > probabilidade_nao_segura
            previsoes_certas_seguras = previsoes_certas_seguras + 1;
        end
    end

    precisao_seguras = previsoes_certas_seguras / length(senhas_seguras_teste);

    previsoes_certas_nao_seguras = 0;
    for i = 1:length(senhas_nao_seguras_teste)
        senha = senhas_nao_seguras_teste{i};
        dados_senha = dados_passe(senha);

        probabilidade_ser_segura = log(prob_segura) + sum(dados_senha .* log(prob_passe_dado_seguro));
        probabilidade_nao_segura = log(prob_nao_segura) + sum(dados_senha .* log(prob_passe_dado_nao_seguro));

        if probabilidade_nao_segura > probabilidade_ser_segura
            previsoes_certas_nao_seguras = previsoes_certas_nao_seguras + 1;
        end
    end

    precisao_nao_seguras = previsoes_certas_nao_seguras / length(senhas_nao_seguras_teste);

    fprintf('Precisão para senhas seguras: %.2f%%\n', precisao_seguras * 100);
    fprintf('Precisão para senhas não seguras: %.2f%%\n', precisao_nao_seguras * 100);
end
