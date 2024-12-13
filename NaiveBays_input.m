function NaiveBays_input()
    load('dados_treino.mat', 'dados_treino');
    load('rotulos_treino.mat', 'rotulos_treino');

    prob_segura = sum(rotulos_treino == 1) / length(rotulos_treino);
    prob_nao_segura = 1 - prob_segura;

    num_dados = size(dados_treino, 2);
    prob_passe_dado_seguro = (sum(dados_treino(rotulos_treino == 1, :)) + 1) ./ (sum(rotulos_treino == 1) + num_dados);
    prob_passe_dado_nao_seguro = (sum(dados_treino(rotulos_treino == 0, :)) + 1) ./ (sum(rotulos_treino == 0) + num_dados);

    while true
        senha = input('Digite uma senha para verificar (ou "sair" para encerrar): ', 's');

        if strcmpi(senha, 'sair')
            disp('Encerrando o programa.');
            break;
        end

        dados_senha = dados_passe(senha);

        probabilidade_ser_segura = log(prob_segura) + sum(dados_senha .* log(prob_passe_dado_seguro));
        probabilidade_nao_segura = log(prob_nao_segura) + sum(dados_senha .* log(prob_passe_dado_nao_seguro));

        if probabilidade_ser_segura > probabilidade_nao_segura
            fprintf('A senha "%s" é classificada como SEGURA.\n', senha);
        else
            fprintf('A senha "%s" é classificada como NÃO SEGURA.\n', senha);
        end
    end
end
