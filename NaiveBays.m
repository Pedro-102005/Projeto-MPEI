senhas_nao_seguras = readtable('passes_nao_seguras.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
senhas_nao_seguras = table2array(senhas_nao_seguras);
senhas_nao_seguras_treino = senhas_nao_seguras(1:900000);
senhas_nao_seguras_teste = senhas_nao_seguras(900001:end);

senhas_seguras = readtable('passes_seguras.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
senhas_seguras = table2array(senhas_seguras);
senhas_seguras_treino = senhas_seguras(1:3000);
senhas_seguras_teste = senhas_seguras(3001:end);

dados_nao_seguras = zeros(length(senhas_nao_seguras_treino), 5); 
dados_seguras = zeros(length(senhas_seguras_treino), 5);

for i = 1:length(senhas_nao_seguras_treino)
    senha = senhas_nao_seguras_treino{i};
    dados_nao_seguras(i, :) = dados_passe(senha); 
end

for i = 1:length(senhas_seguras_treino)
    senha = senhas_seguras_treino{i};
    dados_seguras(i, :) = dados_passe(senha); 
end

dados_treino = [dados_nao_seguras; dados_seguras];
rotulos_treino = [zeros(length(senhas_nao_seguras_treino), 1); ones(length(senhas_seguras_treino), 1)];

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
fprintf('Precisão para senhas seguras: %.2f%%\n', precisao_seguras * 100);

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

% Precisão para senhas não seguras
precisao_nao_seguras = previsoes_certas_nao_seguras / length(senhas_nao_seguras_teste);
fprintf('Precisão para senhas não seguras: %.2f%%\n', precisao_nao_seguras * 100);