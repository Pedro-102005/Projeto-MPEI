function shingles = geracao_shingles(senhas_nao_seguras_teste, tamanho_shingle)
    % Inicializar a célula para armazenar os shingles
    numSenhas = length(senhas_nao_seguras_teste);
    shingles = cell(numSenhas, 1);

    % Percorrer cada senha para gerar os shingles
    for i = 1:numSenhas
        senha = senhas_nao_seguras_teste{i};
        
        % Verificar se a senha é curta
        if length(senha) < tamanho_shingle
            shingles{i} = {senha}; % Nenhum shingle possível
        else
            % Número de shingles necessários
            numShingles = length(senha) - tamanho_shingle + 1;
            shingle_atual = cell(numShingles, 1);
            
            % Gerar os shingles para a senha atual
            for j = 1:numShingles
                shingle_atual{j} = senha(j:j + tamanho_shingle - 1);
            end
            
            shingles{i} = shingle_atual;
        end
    end
    
end
