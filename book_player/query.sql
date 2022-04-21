with tb_lobby as (
    SELECT  * 
    from    tb_lobby_stats_player
    WHERE   dtCreatedAt < '2022-02-01'
    AND     dtCreatedAt > date('2022-02-01', '-30 day')
),

tb_stats as (

    SELECT  idPlayer,
            count(DISTINCT idLobbyGame) as qtPartidas,
            count(DISTINCT case when qtRoundsPlayed < 16 then idLobbyGame end) as qtPartidasMenos16,
            count(DISTINCT date(dtCreatedAt)) as qtDias,
            1.0 * count(DISTINCT idLobbyGame) / count(DISTINCT date(dtCreatedAt)) as mediaPartidasDia,
            avg(qtKill) as avgQtKill,
            avg(qtAssist) as avgQtAssist,
            avg(qtDeath) as avgQtDeath,
            avg(1.0 * (qtKill + qtAssist)/qtDeath) as avgKDA,
            1.0 * sum(qtKill + qtAssist)/sum(qtDeath) as KDAGeral,
            avg(1.0 * (qtKill + qtAssist)/qtRoundsPlayed) as avgKARound,
            1.0 * sum(qtKill + qtAssist)/sum(qtRoundsPlayed) as KARoundGeral,
            avg(qtHs) as avgQtHs,
            avg(1.0 * qtHs / qtKill) as avgHsRate,
            1.0 * sum(qtHs) / sum(qtKill) as txHsGeral,
            avg(qtBombeDefuse) as avgQtBombeDefuse,
            avg(qtBombePlant) as avgQtBombePlant,
            avg(qtTk) as avgQtTk,
            avg(qtTkAssist) as avgQtTkAssist,
            avg(qt1Kill) as avgQt1Kill,
            avg(qt2Kill) as avgQt2Kill,
            avg(qt3Kill) as avgQt3Kill,
            avg(qt4Kill) as avgQt4Kill,
            sum(qt4Kill) as sumQt4Kill,
            avg(qt5Kill) as avgQt5Kill,
            sum(qt5Kill) as sumQt5Kill,
            avg(qtPlusKill) as avgQtPlusKill,
            avg(qtFirstKill) as avgQtFirstKill,
            avg(vlDamage) as avgVlDamage,
            avg(1.0 * vlDamage/qtRoundsPlayed) as avgDamageRound,
            1.0 * sum(vlDamage) / sum(qtRoundsPlayed) as DamageRoundGeral,
            avg(qtHits) as avgQtHits,
            avg(qtShots) as avgQtShots,
            avg(qtLastAlive) as avgQtLastAlive,
            avg(qtClutchWon) as avgQtClutchWon,
            avg(qtRoundsPlayed) as avgQtRoundsPlayed,
            avg(vlLevel) as avgVlLevel,
            avg(qtSurvived) as avgQtSurvived,
            avg(qtTrade) as avgQtTrade,
            avg(qtFlashAssist) as avgQtFlashAssist,
            avg(qtHitHeadshot) as avgQtHitHeadshot,
            avg(qtHitChest) as avgQtHitChest,
            avg(qtHitStomach) as avgQtHitStomach,
            avg(qtHitLeftAtm) as avgQtHitLeftAtm,
            avg(qtHitRightArm) as avgQtHitRightArm,
            avg(qtHitLeftLeg) as avgQtHitLeftLeg,
            avg(qtHitRightLeg) as avgQtHitRightLeg,
            avg(flWinner) as avgFlWinner,
            count( distinct case when descMapName = "de_mirage" then idLobbyGame end) as qtMiragePartidas,
            count( distinct case when descMapName = "de_mirage" and flWinner = 1 then idLobbyGame end) as qtMirageVitorias,
            count( distinct case when descMapName = "de_nuke" then idLobbyGame end) as qtNukePartidas,
            count( distinct case when descMapName = "de_nuke" and flWinner = 1 then idLobbyGame end) as qtNukeVitorias,
            count( distinct case when descMapName = "de_inferno" then idLobbyGame end) as qtInfernoPartidas,
            count( distinct case when descMapName = "de_inferno" and flWinner = 1 then idLobbyGame end) as qtInfernoVitoria,
            count( distinct case when descMapName = "de_vertigo" then idLobbyGame end) as qtVertigoPartidas,
            count( distinct case when descMapName = "de_vertigo" and flWinner = 1 then idLobbyGame end) as qtVertigoVitoria,
            count( distinct case when descMapName = "de_ancient" then idLobbyGame end) as qtAncientPartidas,
            count( distinct case when descMapName = "de_ancient" and flWinner = 1 then idLobbyGame end) as qtAncientVitrias,
            count( distinct case when descMapName = "de_dust2" then idLobbyGame end) as qtDust2Partidas,
            count( distinct case when descMapName = "de_dust2" and flWinner = 1 then idLobbyGame end) as qtDust2Vitoria,
            count( distinct case when descMapName = "de_train" then idLobbyGame end) as qtTrainPartidas,
            count( distinct case when descMapName = "de_train" and flWinner = 1 then idLobbyGame end) as qtTrainVitorias,
            count( distinct case when descMapName = "de_overpass" then idLobbyGame end) as qtOverpassPartidas,
            count( distinct case when descMapName = "de_overpass" and flWinner = 1 then idLobbyGame end) as qtOverpassVitorias

    FROM    tb_lobby
    
    GROUP   BY idPlayer
),

tb_lvl_atual as (
    SELECT  idPlayer,
            vlLevel
    FROM(
        
        SELECT  idLobbyGame,
                idPlayer,
                vlLevel,
                dtCreatedAt,
                row_number() over (PARTITION by idPlayer ORDER BY dtCreatedAt desc) as rn
        from    tb_lobby
    )
    WHERE rn = 1
)


SELECT  t1.*,
        t2.vlLevel as vlLevelAtual
FROM    tb_stats as t1

LEFT    JOIN tb_lvl_atual as t2 on t2.idPlayer = t1.idPlayer
;

    