DROP TABLE if EXISTS tb_abt_sub;
CREATE TABLE tb_abt_sub as
with tb_subs as (
    
    SELECT  idPlayer,
            t1.idMedal,
            dtCreatedAt,
            dtExpiration,
            dtRemove
    FROM    tb_players_medalha as t1
    LEFT    JOIN tb_medalha as t2 on t1.idMedal = t2.idMedal
    WHERE   descMedal in ('Membro Premium', 'Membro Plus')
    AND     coalesce(dtExpiration, date('now')) > dtCreatedAt

)



SELECT  t1.dtRef,
        t1.idPlayer,
        t1.qtPartidas,
        t1.qtPartidasMenos16,
        t1.qtDias,
        t1.qtDiaUltimaLobby,
        t1.mediaPartidasDia,
        t1.avgQtKill,
        t1.avgQtAssist,
        t1.avgQtDeath,
        t1.avgKDA,
        t1.KDAGeral,
        t1.avgKARound,
        t1.KARoundGeral,
        t1.avgQtHs,
        t1.avgHsRate,
        t1.txHsGeral,
        t1.avgQtBombeDefuse,
        t1.avgQtBombePlant,
        t1.avgQtTk,
        t1.avgQtTkAssist,
        t1.avgQt1Kill,
        t1.avgQt2Kill,
        t1.avgQt3Kill,
        t1.avgQt4Kill,
        t1.sumQt4Kill,
        t1.avgQt5Kill,
        t1.sumQt5Kill,
        t1.avgQtPlusKill,
        t1.avgQtFirstKill,
        t1.avgVlDamage,
        t1.avgDamageRound,
        t1.DamageRoundGeral,
        t1.avgQtHits,
        t1.avgQtShots,
        t1.avgQtLastAlive,
        t1.avgQtClutchWon,
        t1.avgQtRoundsPlayed,
        t1.avgVlLevel,
        t1.avgQtSurvived,
        t1.avgQtTrade,
        t1.avgQtFlashAssist,
        t1.avgQtHitHeadshot,
        t1.avgQtHitChest,
        t1.avgQtHitStomach,
        t1.avgQtHitLeftAtm,
        t1.avgQtHitRightArm,
        t1.avgQtHitLeftLeg,
        t1.avgQtHitRightLeg,
        t1.avgFlWinner,
        t1.qtMiragePartidas,
        t1.qtMirageVitorias,
        t1.qtNukePartidas,
        t1.qtNukeVitorias,
        t1.qtInfernoPartidas,
        t1.qtInfernoVitoria,
        t1.qtVertigoPartidas,
        t1.qtVertigoVitoria,
        t1.qtAncientPartidas,
        t1.qtAncientVitrias,
        t1.qtDust2Partidas,
        t1.qtDust2Vitoria,
        t1.qtTrainPartidas,
        t1.qtTrainVitorias,
        t1.qtOverpassPartidas,
        t1.qtOverpassVitorias,
        t1.vlLevelAtual,
        t1.qtMedalhaDistinta,
        t1.qtMedalhaAdquiridas,
        t1.qtPremium,
        t1.qtPlus,
        t1.flFacebook,
        t1.flTwitter,
        t1.flTwitch,
        t1.descCountry,
        t1.dtBirth,
        t1.vlIdade,
        t1.dtRegistration,
        t1.vlDiasCadastro,
        case when t2.idMedal is null then 0 else 1 end as flagSub
FROM    tb_book_players as t1
LEFT    JOIN tb_subs as t2 on t1.idPlayer = t2.idPlayer
AND     t1.dtRef < t2.dtCreatedAt
AND     t2.dtCreatedAt < date(t1.dtRef, '+15 day')

WHERE   AssinaturaAtiva = 0
;

