-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hymns
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hymns
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hymns` DEFAULT CHARACTER SET utf8mb3 ;
USE `hymns` ;

-- -----------------------------------------------------
-- Table `hymns`.`hymn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hymns`.`hymn` (
  `hymn_number` INT NOT NULL,
  `hymn_name` VARCHAR(100) NULL DEFAULT NULL,
  `topic` VARCHAR(45) NULL DEFAULT NULL,
  `last_played` DATE NULL DEFAULT NULL,
  `category` VARCHAR(45) NULL DEFAULT NULL,
  `ranking` INT NULL DEFAULT NULL,
  `musc_link` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`hymn_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE hymns;

SELECT * FROM hymn;

ALTER TABLE hymn
MODIFY COLUMN hymn_name VARCHAR(100);

INSERT INTO hymn (hymn_number, hymn_name, ranking, topic, category)
VALUES 
(1, 'The Morning Breaks', 4, NULL, 'opening'),
(2, 'The Spirit of God', 5, NULL, 'anything'),
(3, 'Now Let Us Rejoice', 5, NULL, 'opening'),
(4, 'Truth Eternal', 2, NULL, 'intermediate'),
(5, 'High on a Mountain Top', 4, NULL, 'opening'),
(6, 'Redeemer of Israel', 4, NULL, 'intermediate'),
(7, 'Israel, Israel, God is Calling', 4, NULL, 'opening'),
(8, 'Awake and Arise', 3, NULL, 'opening'),
(9, 'Come, Rejoice', 3, NULL, 'opening'),
(10, 'Come, Sing to the Lord', 3, NULL, 'opening'),
(11, 'What Was Witnessed in the Heavens?', 2, NULL, 'intermediate'),
(13, 'An Angel from on High', 2, NULL, 'intermediate'),
(14, 'Sweet Is the Peace the Gospel Brings', 3, NULL, 'intermediate'),
(16, 'What Glorious Scenes Mine Eyes Behold', 2, NULL, 'intermediate'),
(17, 'Awake, Ye Saints of God, Awake!', 2, NULL, 'intermediate'),
(18, 'The Voice of God Again is Heard', 2, NULL, 'intermediate'),
(19, 'We Thank Thee, O God, for a Prophet', 4, NULL, 'anything'),
(20, 'God of Power, God of Right', 4, NULL, 'intermediate'),
(21, 'Come, Listen to a Prophet''s Voice', 3, NULL, 'anything'),
(22, 'We Listen to a Prophet''s Voice', 2, NULL, 'intermediate'),
(23, 'We Ever Pray for Thee', 2, NULL, 'closing'),
(24, 'God Bless Our Prophet Dear', 2, NULL, 'anything'),
(25, 'Now We''ll Sing With One Accord', 3, NULL, 'intermediate'),
(26, 'Joseph Smith''s First Prayer', 3, NULL, 'anything'),
(27, 'Praise to the Man', 3, NULL, 'intermediate'),
(28, 'Saints, Behold How Great Jehovah', 2, NULL, 'intermediate'),
(29, 'A Poor Wayfaring Man of Grief', 3, NULL, 'anything'),
(30, 'Come, Come, Ye Saints', 3, NULL, 'opening'),
(31, 'O God, Our Help in Ages Past', 2, NULL, 'intermediate'),
(32, 'The Happy Day at Last Has Come', 2, NULL, 'opening'),
(33, 'Our Mountain Home So Dear', 2, NULL, 'intermediate'),
(34, 'O Ye Mountains High', 3, NULL, 'Closing'),
(35, 'For the Strength of the Hills', 3, NULL, 'Closing'),
(36, 'They, the Builders of the Nation', 2, NULL, 'anything'),
(38, 'Come, All Ye Saints of Zion', 2, NULL, 'opening'),
(39, 'O Saints of Zion', 2, NULL, 'anything'),
(40, 'Arise, O Glorious Zion', 2, NULL, 'anything'),
(41, 'Let Zion in Her Beauty Rise', 3, NULL, 'anything'),
(42, 'Hail to the Brightness of Zion''s glad Morning!', 1, NULL, 'anything'),
(43, 'Zion Stands with Hills Surrounded', 2, NULL, 'anything'),
(44, 'Beautiful Zion, Built Above', 1, NULL, 'anything'),
(45, 'Lead Me Into Life Eternal', 3, NULL, 'closing'),
(46, 'Glorious Things of Thee Are Spoken', 2, NULL, 'intermediate'),
(47, 'We Will Sing of Zion', 2, NULL, 'intermediate'),
(50, 'Come, Though Glorious Day of Promise', 1, NULL, 'anything'),
(52, 'The Day Dawn is Breaking', 3, NULL, 'opening'),
(56, 'Softly Beams the Sacred Dawning', 1, NULL, 'anything'),
(58, 'Come, Ye Children of the Lord', 3, NULL, 'opening'),
(60, 'Battle Hymn of the Republic', 2, '4th of july', 'intermediate'),
(62, 'All creatures of Our God and King', 1, 'easter', 'anything'),
(64, 'On This Day of Joy and Gladness', 2, NULL, 'anything'),
(66, 'Rejoice, the Lord Is King!', 3, NULL, 'anything'),
(67, 'Glory to God on High', 2, NULL, 'intermediate'),
(68, 'A Mighty Fortress Is Our God', 2, NULL, 'anything'),
(69, 'All Glory, Laud, and Honor', 1, 'easter', 'intermediate'),
(78, 'God of Our Fathers, Whose Almighty Hand', 3, '4th of july', 'opening'),
(81, 'Press Forward, Saints', 3, NULL, 'closing'),
(83, 'Guide Us, O Thou Great Jehovah', 3, NULL, 'closing'),
(84, 'Faith of Our Fathers', 3, NULL, 'anything'),
(85, 'How Firm a Foundation', 4, NULL, 'anything'),
(86, 'How Great Thou Art', 2, NULL, 'anything'),
(87, 'God Is Love', 2, NULL, 'opening'),
(89, 'The Lord Is My Light', 3, NULL, 'anything'),
(92, 'For the Beauty of the Earth', 2, 'thanksgiving', 'opening'),
(93, 'Prayer of Thanksgiving', 1, 'thanksgiving', 'opening'),
(94, 'Come, Ye Thankful People', 2, 'thanksgiving', 'opening'),
(96, 'Dearest Children, God is Near You', 2, NULL, 'anything'),
(97, 'Lead, Kindly Light', 3, NULL, 'anything'),
(98, 'I Need Thee Every Hour', 3, NULL, 'anything'),
(100, 'Nearer My God to Thee', 3, NULL, 'anything'),
(105, 'Master, the Tempest Is Raging', 2, NULL, 'intermediate'),
(106, 'God Speed the Right', 3, NULL, 'anything'),
(111, 'Rock of Ages', 2, NULL, 'anything'),
(113, 'Our Savior''s Love', 2, NULL, 'anything'),
(115, 'Come, Ye Disconsolate', 1, NULL, 'anything'),
(116, 'Come, Follow Me', 3, NULL, 'anything'),
(117, 'Come Unto Jesus', 2, NULL, 'anything'),
(122, 'Though Deepening Trials', 2, NULL, 'anything'),
(123, 'Oh, May My Soul Commune With Thee', 2, NULL, 'anything'),
(124, 'Be Still, My Soul', 2, NULL, 'anything'),
(125, 'How Gentle God''s Commands', 3, NULL, 'anything'),
(127, 'Does the Journey Seem Long?', 2, NULL, NULL),
(129, 'Where Can I Turn for Peace?', 3, NULL, NULL),
(130, 'Be Thou Humble', 2, NULL, NULL),
(131, 'More Holiness Give Me', 3, NULL, NULL),
(134, 'I Believe in Christ', 2, 'easter', 'sacrament'),
(135, 'My Redeemer Lives', 2, 'easter', NULL),
(136, 'I Know That My Redeemer Lives', 3, 'easter', NULL),
(139, 'In Fasting We Approach Thee', 1, 'fasting', NULL),
(140, 'Did You Think to Pray?', 3, NULL, NULL),
(141, 'Jesus, the Very Thought of Thee', 2, NULL, NULL),
(142, 'Sweet Hour of Prayer', 3, NULL, NULL),
(143, 'Let the Holy Spirit Guide', 3, NULL, NULL),
(144, 'Secret Prayer', 2, NULL, NULL),
(146, 'Gently Raise the Sacred Strain', 3, NULL, 'sacrament'),
(147, 'Sweet Is the Work', 2, NULL, NULL),
(152, 'God Be with You Till We Meet Again', 1, NULL, 'closing'),
(153, 'Lord, We Ask Thee Ere We Part', 3, NULL, 'closing'),
(156, 'Sing We Now at Parting', 3, NULL, 'closing'),
(158, 'Before Thee, Lord, I Bow My Head', 2, NULL, 'closing'),
(163, 'Lord, Dismiss Us with Thy Blessing', 3, NULL, 'closing'),
(165, 'Abide With me; ''Tis Eventide', 2, NULL, 'closing'),
(166, 'Abide with Me!', 3, NULL, NULL),
(169, 'As Now We Take the Sacrament', 3, NULL, 'sacrament'),
(170, 'God, Our Father, Hear Us Pray', 3, NULL, 'sacrament'),
(171, 'With Humble Heart', 3, NULL, 'sacrament'),
(172, 'In Humility, Our Savior', 3, NULL, 'sacrament'),
(173, 'While of These Emblems We Partake', 3, 'easter', 'sacrament'),
(174, 'While of These Emblems We Partake', 3, 'easter', 'sacrament'),
(175, 'O God, the Eternal Father', 2, NULL, 'sacrament'),
(176, 'Tis Sweet to Sing the Matchless Love', 3, NULL, 'sacrament'),
(179, 'Again, Our Dear Redeeming Lord', 3, NULL, 'sacrament'),
(180, 'Father in Heaven, We Do Believe', 2, NULL, 'sacrament'),
(181, 'Jesus of Nazareth, Savior and King', 3, NULL, 'sacrament'),
(182, 'We''ll Sing All Hail to Jesus Name', 3, NULL, 'sacrament'),
(183, 'In Remembrance of Thy Suffering', 3, NULL, 'sacrament'),
(185, 'Reverently and Meekly Now', 3, NULL, 'sacrament'),
(186, 'Again We Meet Around the Board', 2, NULL, 'sacrament'),
(187, 'God Loved Us, So He Sent His Son', 3, NULL, 'sacrament'),
(188, 'Thy Will, O Lord, Be Done', 3, NULL, 'sacrament'),
(191, 'Behold the Great Redeemer Die', 3, NULL, 'sacrament'),
(192, 'He Died! The Great Redeemer Died', 2, 'easter', 'sacrament'),
(193, 'I Stand All Amazed', 2, NULL, 'sacrament'),
(195, 'How Great the Wisdom and the Love', 3, NULL, 'sacrament'),
(196, 'Jesus, Once of Humble Birth', 3, NULL, 'sacrament'),
(198, 'That Easter Morn', 1, 'easter', NULL),
(199, 'He is Risen!', 1, 'easter', NULL),
(200, 'Christ the Lord Is Risen Today', 1, 'easter', NULL),
(201, 'Joy to the World', 1, 'christmas', NULL),
(202, 'Oh, Come, All Ye Faithful', 1, 'christmas', NULL),
(203, 'Angels We Have Heard on High', 1, 'christmas', NULL),
(204, 'Silent Night', 1, 'christmas', NULL),
(205, 'Once In Royal David''s City', 1, 'christmas', NULL),
(206, 'Away in a Manger', 1, 'christmas', NULL),
(207, 'It Came Upon the Midnight Clear', 1, 'christmas', NULL),
(208, 'O Little Town of Bethlehem', 1, 'christmas', NULL),
(209, 'Hark! The Herald Angels Sing', 1, 'christmas', NULL),
(210, 'With Wondering Awe', 1, 'christmas', NULL),
(212, 'Far, Far Away on Judea''s Plains', 1, 'christmas', NULL),
(213, 'The First Noel', 1, 'christmas', NULL),
(214, 'I Heard the Bells on Christmas Day', 1, 'christmas', NULL),
(215, 'Ring Out, Wild Bells', 1, 'new year''s', NULL),
(216, 'We Are Sowing', 3, NULL, NULL),
(217, 'Come, Let Us Anew', 2, 'new year''s', NULL),
(219, 'Because I Have Been Given Much', 2, 'fasting', NULL),
(220, 'Lord, I Would Follow Thee', 2, NULL, NULL),
(221, 'Dear to the Heart of the Shepherd', 2, NULL, NULL),
(223, 'Have I Done Any Good?', 2, NULL, NULL),
(224, 'I Have Work Enough to Do', 2, NULL, NULL),
(225, 'We Are Marching On to Glory', 2, NULL, NULL),
(226, 'Improve the Shining Moments', 2, NULL, NULL),
(227, 'There Is Sunshine in My Soul Today', 4, NULL, NULL),
(228, 'You Can Make the Pathway Bright', 2, NULL, NULL),
(230, 'Scatter Sunshine', 2, NULL, NULL),
(232, 'Let Us Oft Speak Kind Words', 2, NULL, NULL),
(237, 'Do What Is Right', 3, NULL, NULL),
(239, 'Choose the Right', 3, NULL, NULL),
(241, 'Count Your Blessings', 2, NULL, NULL),
(242, 'Praise God, from Whom All Blessings Flow', 2, NULL, NULL),
(243, 'Let Us All Press On', 3, NULL, NULL),
(248, 'Up, Awake Ye Defenders of Zion', 2, NULL, NULL),
(249, 'Called to Serve', 1, NULL, NULL),
(251, 'Behold! A Royal Army', 2, NULL, NULL),
(254, 'True to the Faith', 2, NULL, NULL),
(255, 'Carry On', 2, NULL, NULL),
(259, 'Hope of Israel', 3, NULL, NULL),
(260, 'Who''s on the Lord''s Side?', 2, NULL, NULL),
(263, 'Go Forth with Faith', 3, NULL, NULL),
(264, 'Hark, All Ye Nations!', 3, NULL, NULL),
(267, 'How Wondrous and Great', 2, NULL, NULL),
(270, 'I''ll Go Where You Want Me to Go', 2, NULL, NULL),
(272, 'Oh Say, What Is Truth?', 2, NULL, NULL),
(274, 'The Iron Rod', 2, NULL, NULL),
(280, 'Welcome, Welcome, Sabbath Morning', 3, NULL, NULL),
(287, 'Rise, Ye Saints, and Temples Enter', 2, NULL, NULL),
(294, 'Love at Home', 3, NULL, NULL),
(296, 'Our Father, by Whose Name', 2, NULL, NULL),
(298, 'Home Can Be a Heaven on Earth', 2, 'mothers', NULL),
(299, 'Children of Our Heavenly Father', 2, NULL, NULL),
(300, 'Families Can Be Together Forever', 2, NULL, NULL),
(301, 'I Am a Child of God', 2, NULL, NULL),
(302, 'I Know My Father Lives', 2, NULL, NULL),
(303, 'Keep the Commandments', 2, NULL, NULL),
(304, 'Teach Me to Walk in the Light', 2, 'mothers', NULL),
(318, 'Love at Home', 2, 'mothers', NULL),
(338, 'America the Beautiful', 1, '4th of july', NULL),
(339, 'My Country, ''Tis of Thee', 1, '4th of july', NULL),
(340, 'The Star-Spangled Banner', 1, '4th of july', NULL);

UPDATE hymn SET category = 'anything'
WHERE category IS NULL;

UPDATE hymn SET last_played = NULL
WHERE hymn_number = 3;

SELECT DISTINCT topic 
FROM hymn;

SELECT * FROM 2023_08_06;
