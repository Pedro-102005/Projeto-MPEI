load('senhas_nao_seguras_teste.mat');
tamanho_shingle=3;
shingles = geracao_shingles(senhas_nao_seguras_teste, tamanho_shingle);
save('shingles.mat', 'shingles');
k = 500; 
num_senhas = length(shingles);
assinaturas = zeros(k, num_senhas);


for i = 1:num_senhas
    conjunto_shingles = shingles{i};
    conjunto_hashes = zeros(length(conjunto_shingles), k);
    for j = 1:length(conjunto_shingles)
        % para cada senha transforma todos os shingles em hash e armazena num cell array
        hashes = string2hash_aux(conjunto_shingles{j}, k);
        conjunto_hashes(j, :) = hashes;
    end
    %vai percorrer cada linha e encontrar o menor valor de hash e vai guardalo
    assinaturas(:, i) = min(conjunto_hashes, [], 1); % MinHash
end

save('assinaturas','assinaturas')

