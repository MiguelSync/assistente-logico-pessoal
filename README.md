# Assistente Lógico Pessoal

> Atividade da disciplina Linguagem de Programação e Paradigmas · UNIDAVI · 2026/2

**Aluno:** Miguel Antonio Selhorst
**Linguagem do sistema:** Python

## O que é

Uma base de conhecimento em Prolog (`meus_dados.pl`) com fatos e regras sobre mim e um assistente em linha de comando (`assistente.py`) que consulta essa base pela ponte `prolog.py`. O Prolog decide **o que** é verdade; o Python decide **o que fazer** com as respostas (list comprehensions para transformar a lista de soluções).

## Como executar

Requisitos: SWI-Prolog no PATH e Python 3 (sem bibliotecas extras).

```bash
# testar a ponte
python teste_ponte.py

# executar o assistente
python assistente.py
```

No Linux/Mac, use `python3`. No Windows, se `python` não funcionar, use `py`.

## Minha base

- Fatos: `eu/1`, `cursa/3`, `compromisso/3`, `sabe/2`, `gosta/2`
- Regras: `ocupado/2`, `livre/2`, `o_que_faco/3`, `pode_ensinar/1`, `dia_cheio/1` e a minha regra abaixo

## Minha regra (R6)

```prolog
ranqueada(Dia, Campeao) :-
    livre(Dia, noite),
    gosta(jogo, league_of_legends),
    gosta(campeao, Campeao).
```

**O que ela significa:** diz em quais noites da semana eu posso jogar uma ranqueada de League of Legends e com qual dos meus mains. `livre(Dia, noite)` verifica se a noite do dia não tem aula nem compromisso (usa R2, que por sua vez usa negação por falha sobre R1); `gosta(jogo, league_of_legends)` confirma que eu jogo LoL; `gosta(campeao, Campeao)` percorre, por backtracking, os campeões que eu jogo como main. Cada combinação dia + campeão que satisfaz os três subobjetivos é uma resposta.

## Saída real do assistente

```text
=== Assistente pessoal de miguel ===
1. Minhas disciplinas
2. Agenda de um dia
3. Horários livres
4. Estou livre em...?
5. Linguagens que posso ensinar
6. Meus gostos por categoria
7. Dias cheios
8. Minha regra: noites de ranqueada
0. Sair
> 1

== Minhas disciplinas ==
  - lpp (segunda, noite)
  - redes_de_computadores (terca, noite)
  - plataformas_moveis (quarta, noite)
  - gerencia_de_projetos (quinta, noite)
  - programacao_web_2 (sexta, noite)

=== Assistente pessoal de miguel ===
...
> 3

== Horários livres ==
  - sabado de tarde
  - sabado de noite

=== Assistente pessoal de miguel ===
...
> 4
Dia: sabado
Turno (manha, tarde, noite): noite

Sim! sabado de noite está livre.

=== Assistente pessoal de miguel ===
...
> 5

== Linguagens que posso ensinar ==
  - HTML
  - CSS
  - JAVASCRIPT
  - PHP
  - LIQUID

=== Assistente pessoal de miguel ===
...
> 8

== Noites de ranqueada ==
  - sabado à noite com Yone
  - sabado à noite com Irelia

=== Assistente pessoal de miguel ===
...
> 2
Qual dia? (segunda, terca, quarta, quinta, sexta, sabado): Seg unda!
Ops: Digite só letras minúsculas, números e _ (sem acento).

=== Assistente pessoal de miguel ===
...
> 0
Até mais!
```
