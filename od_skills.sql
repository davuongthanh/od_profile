CREATE TABLE `od_skills` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `stamina` varchar(255) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `driving` varchar(255) DEFAULT NULL,
  `shooting` varchar(255) DEFAULT NULL,
  `fishing` varchar(255) DEFAULT NULL,
  `drugs` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `od_skills`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `od_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;