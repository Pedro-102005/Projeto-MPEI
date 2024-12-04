% Dados de treino: [Comprimento > 8, Números > 1, Maiúsculas > 1, Símbolos > 1, tem Caracteres repetidos > 3]
dados = [
    1, 1, 1, 1, 0; 
    1, 0, 1, 0, 0; 
    0, 1, 0, 1, 1; 
    1, 1, 1, 1, 1; 
    0, 0, 0, 0, 0;
    0, 0, 1, 1, 1;
    1, 1, 0, 0, 0;
    1, 0, 1, 1, 0;
    1, 1, 0, 1, 0;
];

% 1 = Seguro e 0 = Não seguro
defenicao = [1; 0; 0; 1; 0; 0; 0; 1; 1];

% Probabilidade
prob_segura = sum(defenicao == 1) / length(defenicao);
prob_nao_segura = 1-prob_segura;

% Probabilidade condicional
num_dados = size(dados, 2);
prob_passe_dado_seguro = sum(dados(defenicao == 1, :)) ./ sum(defenicao == 1);
prob_passe_dado_nao_seguro = sum(dados(defenicao == 0, :)) ./ sum(defenicao == 0);

% Pede ao utilizador
senha = input('Insira a senha para verificar: ', 's');

%validações
if ~all(isstrprop(senha, 'print'))
    error('A senha contém caracteres inválidos.');
end

dados_senha = dados_passe(senha);

probabilidade_ser_segura = prod(prob_passe_dado_seguro(dados_senha == 1)) * prod(1 - prob_passe_dado_seguro(dados_senha == 0));
probabilidade_nao_segura = prod(prob_passe_dado_nao_seguro(dados_senha == 1)) * prod(1 - prob_passe_dado_nao_seguro(dados_senha == 0));

% P(classe/evidencia) = P(Evidencia/classe) * P(Classe)
posterior_segura = probabilidade_ser_segura * prob_segura;
posterior_nao_segura = probabilidade_nao_segura * prob_nao_segura;

if posterior_segura > posterior_nao_segura
    disp('A senha é segura.');
else
    disp('A senha não é segura.');
end