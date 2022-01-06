CREATE VIEW season_view AS 
SELECT `seasons`.`idSeason` AS `idSeason`,
`seasons`.`idShow` AS `idShow`,
`seasons`.`season` AS `season`,
`seasons`.`name` AS `name`,
`seasons`.`userrating` AS `userrating`,
(SELECT `path`.`strPath` FROM tvshowlinkpath_minview left join `path` ON `path`.`idPath` = `tvshowlinkpath_minview`.`idPath` WHERE tvshowlinkpath_minview.idShow = seasons.idShow ) AS strPath,
`tvshow`.`c00` AS `showTitle`,
`tvshow`.`c01` AS `plot`,
`tvshow`.`c05` AS `premiered`,
`tvshow`.`c08` AS `genre`,
`tvshow`.`c14` AS `studio`,
`tvshow`.`c13` AS `mpaa`,
(SELECT COUNT(distinct `episode`.`idEpisode`) FROM `episode` WHERE `episode`.`idShow` = `seasons`.`idShow` AND `episode`.`c12` = `seasons`.`season`) AS episodes,
(SELECT COUNT (`files`.`playCount`) FROM `episode` INNER JOIN `files` ON `files`.`idFile` = `episode`.`idFile` WHERE `episode`.`idShow` = `seasons`.`idShow` AND `episode`.`c12` = `seasons`.`season`) AS playCount,
(SELECT MIN(`episode`.`c05`) FROM `episode` WHERE `episode`.`idShow` = `seasons`.`idShow` AND `episode`.`c12` = `seasons`.`season`) AS aired
FROM `seasons`
inner join `tvshow` on `tvshow`.`idShow` = `seasons`.`idShow`
WHERE episodes > 0
