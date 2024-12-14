load('shingles.mat','shingles')
load('senhas_nao_seguras_teste.mat','senhas_nao_seguras_teste');
load('assinaturas.mat','assinaturas');
% Carregar dados

tamanho_shingle = 3;
k = 500; 
limiar_similaridade = 0.7;

% Solicitar senha ao usuário
senha_usuario = input('Digite sua senha: ', 's');
shingles_usuario = geracao_shingles({senha_usuario}, tamanho_shingle);
shingles_usuario = shingles_usuario{1};

% Gerar assinatura MinHash para a senha do usuário
hashes_usuario = zeros(length(shingles_usuario), k);
for i = 1:length(shingles_usuario)
    hashes = string2hash_aux(shingles_usuario{i}, k);
    hashes_usuario(i, :) = hashes;
end
assinatura_usuario = min(hashes_usuario, [], 1);

% Calcular similaridade de MinHash e encontrar senhas similares
similaridades = zeros(1, num_senhas);

for i = 1:num_senhas
    % Jaccard
    similaridades(i) = sum(assinaturas(:, i) == assinatura_usuario') / length(assinaturas(:,1));
end
% Verificar senhas com similaridade maior que o limiar
idx_similares = find(similaridades >= limiar_similaridade);

if isempty(idx_similares)
    fprintf('Nenhuma senha similar encontrada.\n');
else
    % Ordenar os índices de senhas similares por similaridade em ordem decrescente
    [~, ordem] = sort(similaridades(idx_similares), 'descend');
    idx_similares = idx_similares(ordem);

    % Exibir as senhas similares ordenadas por similaridade
    fprintf('Senhas similares encontradas (ordenadas por similaridade):\n');
    for i = 1:length(idx_similares)
        senha_similar = senhas_nao_seguras_teste{idx_similares(i)};
        fprintf('Senha: %s - Similaridade: %.2f%%\n', senha_similar, similaridades(idx_similares(i)) * 100);
    end
end
