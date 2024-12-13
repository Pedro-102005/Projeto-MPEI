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

save('dados_treino.mat', 'dados_treino');
save('rotulos_treino.mat', 'rotulos_treino');

dados_nao_seguras_teste = zeros(length(senhas_nao_seguras_teste), 5); 
dados_seguras_teste = zeros(length(senhas_seguras_teste), 5);

for i = 1:length(senhas_nao_seguras_teste)
    senha = senhas_nao_seguras_teste{i};
    dados_nao_seguras_teste(i, :) = dados_passe(senha); 
end

for i = 1:length(senhas_seguras_teste)
    senha = senhas_seguras_teste{i};
    dados_seguras_teste(i, :) = dados_passe(senha); 
end

dados_teste = [dados_nao_seguras_teste; dados_seguras_teste];
save('senhas_seguras_teste.mat', 'senhas_seguras_teste');
save('senhas_nao_seguras_teste.mat', 'senhas_nao_seguras_teste');