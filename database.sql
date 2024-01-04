CREATE DATABASE  IF NOT EXISTS `thesisdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `thesisdb`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: thesisdb
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add criteria',7,'add_criteria'),(26,'Can change criteria',7,'change_criteria'),(27,'Can delete criteria',7,'delete_criteria'),(28,'Can view criteria',7,'view_criteria'),(29,'Can add member of thesis defense committee',8,'add_memberofthesisdefensecommittee'),(30,'Can change member of thesis defense committee',8,'change_memberofthesisdefensecommittee'),(31,'Can delete member of thesis defense committee',8,'delete_memberofthesisdefensecommittee'),(32,'Can view member of thesis defense committee',8,'view_memberofthesisdefensecommittee'),(33,'Can add position',9,'add_position'),(34,'Can change position',9,'change_position'),(35,'Can delete position',9,'delete_position'),(36,'Can view position',9,'view_position'),(37,'Can add status thesis',10,'add_statusthesis'),(38,'Can change status thesis',10,'change_statusthesis'),(39,'Can delete status thesis',10,'delete_statusthesis'),(40,'Can view status thesis',10,'view_statusthesis'),(41,'Can add thesis',11,'add_thesis'),(42,'Can change thesis',11,'change_thesis'),(43,'Can delete thesis',11,'delete_thesis'),(44,'Can view thesis',11,'view_thesis'),(45,'Can add thesis defense committee',12,'add_thesisdefensecommittee'),(46,'Can change thesis defense committee',12,'change_thesisdefensecommittee'),(47,'Can delete thesis defense committee',12,'delete_thesisdefensecommittee'),(48,'Can view thesis defense committee',12,'view_thesisdefensecommittee'),(49,'Can add thesis supervisor',13,'add_thesissupervisor'),(50,'Can change thesis supervisor',13,'change_thesissupervisor'),(51,'Can delete thesis supervisor',13,'delete_thesissupervisor'),(52,'Can view thesis supervisor',13,'view_thesissupervisor'),(53,'Can add thesis student',14,'add_thesisstudent'),(54,'Can change thesis student',14,'change_thesisstudent'),(55,'Can delete thesis student',14,'delete_thesisstudent'),(56,'Can view thesis student',14,'view_thesisstudent'),(57,'Can add thesis examination committee',15,'add_thesisexaminationcommittee'),(58,'Can change thesis examination committee',15,'change_thesisexaminationcommittee'),(59,'Can delete thesis examination committee',15,'delete_thesisexaminationcommittee'),(60,'Can view thesis examination committee',15,'view_thesisexaminationcommittee'),(61,'Can add score',16,'add_score'),(62,'Can change score',16,'change_score'),(63,'Can delete score',16,'delete_score'),(64,'Can view score',16,'view_score'),(65,'Can add role',17,'add_role'),(66,'Can change role',17,'change_role'),(67,'Can delete role',17,'delete_role'),(68,'Can view role',17,'view_role'),(69,'Can add majors',18,'add_majors'),(70,'Can change majors',18,'change_majors'),(71,'Can delete majors',18,'delete_majors'),(72,'Can view majors',18,'view_majors'),(73,'Can add application',19,'add_application'),(74,'Can change application',19,'change_application'),(75,'Can delete application',19,'delete_application'),(76,'Can view application',19,'view_application'),(77,'Can add access token',20,'add_accesstoken'),(78,'Can change access token',20,'change_accesstoken'),(79,'Can delete access token',20,'delete_accesstoken'),(80,'Can view access token',20,'view_accesstoken'),(81,'Can add grant',21,'add_grant'),(82,'Can change grant',21,'change_grant'),(83,'Can delete grant',21,'delete_grant'),(84,'Can view grant',21,'view_grant'),(85,'Can add refresh token',22,'add_refreshtoken'),(86,'Can change refresh token',22,'change_refreshtoken'),(87,'Can delete refresh token',22,'delete_refreshtoken'),(88,'Can view refresh token',22,'view_refreshtoken'),(89,'Can add id token',23,'add_idtoken'),(90,'Can change id token',23,'change_idtoken'),(91,'Can delete id token',23,'delete_idtoken'),(92,'Can view id token',23,'view_idtoken');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_ThesisManagement_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_ThesisManagement_user_id` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-01-04 02:41:21.745857','4','Kha Nguyễn Minh',1,'[{\"added\": {}}]',6,1),(2,'2024-01-04 02:42:33.148108','5','Trí Nguyễn Minh',1,'[{\"added\": {}}]',6,1),(3,'2024-01-04 02:45:24.625889','6','Nguyễn Thị Trang',1,'[{\"added\": {}}]',6,1),(4,'2024-01-04 02:45:47.888990','7',' ',1,'[{\"added\": {}}]',6,1),(5,'2024-01-04 02:46:07.511693','8',' ',1,'[{\"added\": {}}]',6,1),(6,'2024-01-04 02:46:26.471874','9',' ',1,'[{\"added\": {}}]',6,1),(7,'2024-01-04 02:46:40.235776','10',' ',1,'[{\"added\": {}}]',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(20,'oauth2_provider','accesstoken'),(19,'oauth2_provider','application'),(21,'oauth2_provider','grant'),(23,'oauth2_provider','idtoken'),(22,'oauth2_provider','refreshtoken'),(5,'sessions','session'),(7,'ThesisManagement','criteria'),(18,'ThesisManagement','majors'),(8,'ThesisManagement','memberofthesisdefensecommittee'),(9,'ThesisManagement','position'),(17,'ThesisManagement','role'),(16,'ThesisManagement','score'),(10,'ThesisManagement','statusthesis'),(11,'ThesisManagement','thesis'),(12,'ThesisManagement','thesisdefensecommittee'),(15,'ThesisManagement','thesisexaminationcommittee'),(14,'ThesisManagement','thesisstudent'),(13,'ThesisManagement','thesissupervisor'),(6,'ThesisManagement','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-01-04 02:28:52.274562'),(2,'contenttypes','0002_remove_content_type_name','2024-01-04 02:28:52.326643'),(3,'auth','0001_initial','2024-01-04 02:28:52.514248'),(4,'auth','0002_alter_permission_name_max_length','2024-01-04 02:28:52.559387'),(5,'auth','0003_alter_user_email_max_length','2024-01-04 02:28:52.566184'),(6,'auth','0004_alter_user_username_opts','2024-01-04 02:28:52.573699'),(7,'auth','0005_alter_user_last_login_null','2024-01-04 02:28:52.580400'),(8,'auth','0006_require_contenttypes_0002','2024-01-04 02:28:52.583695'),(9,'auth','0007_alter_validators_add_error_messages','2024-01-04 02:28:52.589303'),(10,'auth','0008_alter_user_username_max_length','2024-01-04 02:28:52.598262'),(11,'auth','0009_alter_user_last_name_max_length','2024-01-04 02:28:52.604715'),(12,'auth','0010_alter_group_name_max_length','2024-01-04 02:28:52.617509'),(13,'auth','0011_update_proxy_permissions','2024-01-04 02:28:52.624953'),(14,'auth','0012_alter_user_first_name_max_length','2024-01-04 02:28:52.632441'),(15,'ThesisManagement','0001_initial','2024-01-04 02:28:53.436992'),(16,'ThesisManagement','0002_user_avatar_user_phone_alter_criteria_name_and_more','2024-01-04 02:28:53.587152'),(17,'ThesisManagement','0003_delete_criteria_and_more','2024-01-04 02:28:54.212169'),(18,'ThesisManagement','0004_alter_user_groups_alter_user_user_permissions','2024-01-04 02:28:54.221932'),(19,'ThesisManagement','0005_criteria_memberofthesisdefensecommittee_position_and_more','2024-01-04 02:28:54.861509'),(20,'ThesisManagement','0006_alter_user_groups_alter_user_user_permissions','2024-01-04 02:28:54.879354'),(21,'ThesisManagement','0007_score_thesis','2024-01-04 02:28:54.935559'),(22,'ThesisManagement','0008_alter_user_avatar_alter_user_phone','2024-01-04 02:28:54.952425'),(23,'ThesisManagement','0009_user_role','2024-01-04 02:28:54.999423'),(24,'ThesisManagement','0010_role_alter_user_role','2024-01-04 02:28:55.185389'),(25,'ThesisManagement','0011_alter_user_role','2024-01-04 02:28:55.315532'),(26,'ThesisManagement','0012_alter_user_role','2024-01-04 02:28:55.367316'),(27,'ThesisManagement','0013_alter_user_role','2024-01-04 02:28:55.378403'),(28,'ThesisManagement','0014_alter_user_role','2024-01-04 02:28:55.387128'),(29,'ThesisManagement','0015_remove_thesisexaminationcommittee_committee_and_more','2024-01-04 02:28:55.584320'),(30,'ThesisManagement','0016_thesis_status','2024-01-04 02:28:55.655875'),(31,'ThesisManagement','0017_remove_thesisdefensecommittee_thesis_and_more','2024-01-04 02:28:55.780422'),(32,'ThesisManagement','0018_remove_thesis_committee_thesis_committee','2024-01-04 02:28:55.849941'),(33,'ThesisManagement','0019_alter_user_avatar','2024-01-04 02:28:55.953662'),(34,'ThesisManagement','0020_rename_memberofcommittee_score_lecturer_and_more','2024-01-04 02:28:56.106985'),(35,'ThesisManagement','0021_score_criteria','2024-01-04 02:28:56.163238'),(36,'ThesisManagement','0022_alter_score_lecturer_alter_score_student','2024-01-04 02:28:56.372392'),(37,'ThesisManagement','0023_alter_score_score','2024-01-04 02:28:56.420818'),(38,'ThesisManagement','0024_majors_alter_user_role_thesis_major_user_major','2024-01-04 02:28:56.623785'),(39,'ThesisManagement','0025_user_temp_password','2024-01-04 02:28:56.654122'),(40,'ThesisManagement','0026_thesisstudent_total_alter_score_score','2024-01-04 02:28:56.721073'),(41,'admin','0001_initial','2024-01-04 02:28:56.820461'),(42,'admin','0002_logentry_remove_auto_add','2024-01-04 02:28:56.830421'),(43,'admin','0003_logentry_add_action_flag_choices','2024-01-04 02:28:56.839969'),(44,'oauth2_provider','0001_initial','2024-01-04 02:28:57.439011'),(45,'oauth2_provider','0002_auto_20190406_1805','2024-01-04 02:28:57.493662'),(46,'oauth2_provider','0003_auto_20201211_1314','2024-01-04 02:28:57.540925'),(47,'oauth2_provider','0004_auto_20200902_2022','2024-01-04 02:28:57.889105'),(48,'oauth2_provider','0005_auto_20211222_2352','2024-01-04 02:28:57.955322'),(49,'oauth2_provider','0006_alter_application_client_secret','2024-01-04 02:28:57.982934'),(50,'oauth2_provider','0007_application_post_logout_redirect_uris','2024-01-04 02:28:58.056041'),(51,'sessions','0001_initial','2024-01-04 02:28:58.092766'),(52,'ThesisManagement','0027_alter_user_avatar','2024-01-04 02:43:57.386364');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('p6qya17lxhq2r1rcll71oltzoawpjzgq','.eJxVjDsOwjAQBe_iGlneOGtnKek5g7XrDwmgWIqTCnF3iJQC2jcz76UCb-sYtpaXMCV1VqBOv5twfOR5B-nO863qWOd1mUTvij5o09ea8vNyuH8HI7fxW3Pp2EVCHMSYHgWIYkmE4KnvbDEWxKAXOxgWsEzOEwhBN7jiGJHV-wPH_Dbh:1rLDYI:9jFfw3rTjhbgv57_QRfWSi56eH-3cnP17EA6Q25WTbc','2024-01-18 02:33:46.464775');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_acce_user_id_6e4c9a65_fk_ThesisMan` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_user_id_6e4c9a65_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'t1FjfnEkCCa9yMG1qNZzzPBBGSb43L','2024-01-04 13:00:25.726908','read write',1,1,'2024-01-04 03:00:25.726908','2024-01-04 03:00:25.726908',NULL,NULL),(2,'EeD6VTNp2L11hyFzg1VG7wCOtpnemQ','2024-01-04 14:58:28.507926','read write',1,1,'2024-01-04 04:58:28.507926','2024-01-04 04:58:28.507926',NULL,NULL),(3,'JvcJjQr8cyauTu3cGrFkHw9H4v573s','2024-01-04 15:00:54.326523','read write',1,1,'2024-01-04 05:00:54.327486','2024-01-04 05:00:54.327486',NULL,NULL),(4,'PO3OL7wfJAk082vhpNrXpOUudVipqz','2024-01-04 15:15:25.707755','read write',1,1,'2024-01-04 05:15:25.707755','2024-01-04 05:15:25.707755',NULL,NULL),(5,'2RkLkHK1hgzlAOAe4RMnT3pufHh73v','2024-01-04 15:38:15.527567','read write',1,1,'2024-01-04 05:38:15.527567','2024-01-04 05:38:15.527567',NULL,NULL),(6,'xVMknFeDl2yK7g3h4WSytRHcpfCPQS','2024-01-04 16:33:45.761732','read write',1,1,'2024-01-04 06:33:45.761732','2024-01-04 06:33:45.761732',NULL,NULL),(7,'sXLmKAlvUb2TxvQSLuuroeZMmobk3P','2024-01-04 16:42:59.754286','read write',1,1,'2024-01-04 06:42:59.754286','2024-01-04 06:42:59.754286',NULL,NULL),(8,'v87hI4hgUtZQW0aI6aslthb6Mzmq5F','2024-01-04 16:43:24.504966','read write',1,1,'2024-01-04 06:43:24.504966','2024-01-04 06:43:24.504966',NULL,NULL),(9,'ga4XDmsVXuZdj6OFZxPIUeBfqluOfk','2024-01-04 16:44:33.872057','read write',1,1,'2024-01-04 06:44:33.872057','2024-01-04 06:44:33.872057',NULL,NULL),(10,'7ZEEfJl3TNAkPrmgp4eLSUNAR2YUN1','2024-01-04 16:45:34.377491','read write',1,1,'2024-01-04 06:45:34.377491','2024-01-04 06:45:34.377491',NULL,NULL),(11,'hEc7OMuC8qcb2El52QuK5rfpVkPNkS','2024-01-04 16:46:17.829470','read write',1,1,'2024-01-04 06:46:17.829470','2024-01-04 06:46:17.829470',NULL,NULL),(12,'UJ85bkYWPO8uh5AQCDnq5wLJzn1jXX','2024-01-04 16:52:01.894258','read write',1,1,'2024-01-04 06:52:01.894258','2024-01-04 06:52:01.894258',NULL,NULL),(13,'wv9UuF4xC4DfwBjQ8gGL7R6vxWC6Kz','2024-01-04 16:52:29.485949','read write',1,1,'2024-01-04 06:52:29.485949','2024-01-04 06:52:29.485949',NULL,NULL),(14,'1pscWQo5rj3Iokh6eatuMAxmoCDlEY','2024-01-04 16:57:48.117984','read write',1,1,'2024-01-04 06:57:48.117984','2024-01-04 06:57:48.117984',NULL,NULL),(15,'DMOOqqzVVtE94OtJMwXr8XhyF3iHXI','2024-01-04 17:01:57.012047','read write',1,1,'2024-01-04 07:01:57.013553','2024-01-04 07:01:57.013553',NULL,NULL),(16,'G0vCbbNptUsZe1GnbqruLEbdbzccrM','2024-01-04 17:02:21.533198','read write',1,1,'2024-01-04 07:02:21.533198','2024-01-04 07:02:21.533198',NULL,NULL),(17,'3Kbsvki4KC3pHpk8FKdxh0jElXzoHU','2024-01-04 17:04:20.546785','read write',1,1,'2024-01-04 07:04:20.546785','2024-01-04 07:04:20.546785',NULL,NULL),(18,'LPD5SO5E3MpViNC9fKKHQh2tPfUED3','2024-01-04 17:05:08.695878','read write',1,1,'2024-01-04 07:05:08.696844','2024-01-04 07:05:08.696844',NULL,NULL),(19,'oiTJKTGfQcKekCme5KhlC3AZwhkT8r','2024-01-04 17:05:52.626915','read write',1,1,'2024-01-04 07:05:52.627913','2024-01-04 07:05:52.627913',NULL,NULL),(20,'ScmaW8oyoX8Un2cAYhxm15mfaTrNnP','2024-01-04 17:06:37.327481','read write',1,1,'2024-01-04 07:06:37.327481','2024-01-04 07:06:37.327481',NULL,NULL),(21,'pitzb9btQKjqQaT4DFuMBqegc5wlzY','2024-01-04 17:07:21.650107','read write',1,1,'2024-01-04 07:07:21.650107','2024-01-04 07:07:21.650107',NULL,NULL),(22,'l3KEJQ4y5BiTA01FSlA68e7nz12WLu','2024-01-04 17:09:01.765238','read write',1,1,'2024-01-04 07:09:01.765238','2024-01-04 07:09:01.765238',NULL,NULL),(23,'mjC4uIhiWTd4Gz3fiCacSUg0Qh9FIw','2024-01-04 17:09:17.482452','read write',1,1,'2024-01-04 07:09:17.482452','2024-01-04 07:09:17.482452',NULL,NULL),(24,'vDsqBFhHVpBoaFFWYjrU3Z39TtGsFA','2024-01-04 17:10:07.067477','read write',1,1,'2024-01-04 07:10:07.068436','2024-01-04 07:10:07.068436',NULL,NULL),(25,'OkntC7i31kdAj42GvMGaUsP1G5gbLn','2024-01-04 17:43:36.372706','read write',1,1,'2024-01-04 07:43:36.372706','2024-01-04 07:43:36.372706',NULL,NULL),(26,'bfvpC6vEB2JDxuUAqjTic6PEl83mzc','2024-01-04 17:46:02.614329','read write',1,1,'2024-01-04 07:46:02.614329','2024-01-04 07:46:02.614329',NULL,NULL),(27,'ClQ87lLiKNPLUJO0bYrCWf4DlibreC','2024-01-04 18:04:35.832640','read write',1,35,'2024-01-04 08:04:35.832640','2024-01-04 08:04:35.832640',NULL,NULL),(28,'DK42hnGQqG3DKoybqOacPmEKIQN1Gq','2024-01-04 18:15:14.007759','read write',1,39,'2024-01-04 08:15:14.008758','2024-01-04 08:15:14.008758',NULL,NULL),(29,'kkSredOdLsA16wjOsugwDg1lT4KHrS','2024-01-04 18:40:05.459705','read write',1,41,'2024-01-04 08:40:05.460703','2024-01-04 08:40:05.460703',NULL,NULL),(30,'UZy7QfBLguSrirAJZGMwl72YleP6GK','2024-01-04 18:53:54.942196','read write',1,38,'2024-01-04 08:53:54.942196','2024-01-04 08:53:54.942196',NULL,NULL),(31,'gZkH9JMTqsDJkImc0TQ6SrxLvhPcfZ','2024-01-04 18:55:57.289264','read write',1,38,'2024-01-04 08:55:57.289264','2024-01-04 08:55:57.289264',NULL,NULL),(32,'79uwUk8DpX9s6ewnmAtQSSQSuUGaTy','2024-01-04 18:57:24.897957','read write',1,38,'2024-01-04 08:57:24.897957','2024-01-04 08:57:24.897957',NULL,NULL),(33,'V5lanUPiqFVCK4kmGd3C1b7ySgpaCd','2024-01-04 18:57:55.885378','read write',1,38,'2024-01-04 08:57:55.885378','2024-01-04 08:57:55.885378',NULL,NULL),(34,'p1mzQe29Cxnis5Uo4JjVmu6g1i9yDK','2024-01-04 19:17:49.278164','read write',1,1,'2024-01-04 09:17:49.278164','2024-01-04 09:17:49.279247',NULL,NULL);
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `authorization_grant_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_logout_redirect_uris` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_appl_user_id_79829054_fk_ThesisMan` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_appl_user_id_79829054_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
INSERT INTO `oauth2_provider_application` VALUES (1,'kECtsLYTTj8xy1BbpTQ0CNjAGyeOl7w7SmAc8Vl8','','confidential','password','pbkdf2_sha256$600000$HT5quWlEldjsYqLQhkkinp$XD7QOPHw8t6IkM1ULKVt3p4WrOMpAl4tt82t7UGq9Dw=','ThesisApp',1,0,'2024-01-04 02:34:47.224986','2024-01-04 02:34:47.224986','','');
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_challenge_method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `claims` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_gran_user_id_e8f62af8_fk_ThesisMan` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_gran_user_id_e8f62af8_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_idtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idto_user_id_dd512b59_fk_ThesisMan` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idto_user_id_dd512b59_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_idtoken`
--

LOCK TABLES `oauth2_provider_idtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refr_user_id_da837fce_fk_ThesisMan` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refr_user_id_da837fce_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'79bXVFk5ucxM0mDi18FEQH751FkUbh',1,1,1,'2024-01-04 03:00:25.728814','2024-01-04 03:00:25.728814',NULL),(2,'CWO9Mvfaxo0cSgVeJd0IFStHb3kzr9',2,1,1,'2024-01-04 04:58:28.527678','2024-01-04 04:58:28.527678',NULL),(3,'NPHnE6F9Pi6kgpiXNjOo88Ov54ekIO',3,1,1,'2024-01-04 05:00:54.333621','2024-01-04 05:00:54.333621',NULL),(4,'W30rGLtl9r8L9FH3pcRJaLjLCyYYW7',4,1,1,'2024-01-04 05:15:25.707755','2024-01-04 05:15:25.707755',NULL),(5,'chIGaNuq9NimFFoVmirsnouqPNSf0S',5,1,1,'2024-01-04 05:38:15.543220','2024-01-04 05:38:15.543220',NULL),(6,'h6CrpvpkcY2SGZ5jdBJ0fYVfaIVDA6',6,1,1,'2024-01-04 06:33:45.775774','2024-01-04 06:33:45.775774',NULL),(7,'UJvXUJX6rMPAyjBRG8oIWJuvDWs7pz',7,1,1,'2024-01-04 06:42:59.757815','2024-01-04 06:42:59.757815',NULL),(8,'n0hrVfwcGg7RXd1ksRm751aKc7mxyY',8,1,1,'2024-01-04 06:43:24.508981','2024-01-04 06:43:24.508981',NULL),(9,'ZYBFPZ6Q9yLaoBjIyhSixiVizAxJj5',9,1,1,'2024-01-04 06:44:33.872057','2024-01-04 06:44:33.872057',NULL),(10,'YuZCwlhpMizmoSPZrDzvc0bRhPd8vn',10,1,1,'2024-01-04 06:45:34.377491','2024-01-04 06:45:34.377491',NULL),(11,'0x3LNYPLz7l9hewYlOCMHOvvC8jlH6',11,1,1,'2024-01-04 06:46:17.834318','2024-01-04 06:46:17.834318',NULL),(12,'lBvWG1XcBBYAZBbP3Kgzn14CL3DuBm',12,1,1,'2024-01-04 06:52:01.909880','2024-01-04 06:52:01.909880',NULL),(13,'YYo2vTVtfpV3ZhUMZdl3IJjkWbC8ay',13,1,1,'2024-01-04 06:52:29.485949','2024-01-04 06:52:29.485949',NULL),(14,'EGJao0YACty3BouGD7grMWW6UgCnp5',14,1,1,'2024-01-04 06:57:48.121657','2024-01-04 06:57:48.121657',NULL),(15,'VYzKrdiZzzpm8ErKB5NVlibHKjY23T',15,1,1,'2024-01-04 07:01:57.013553','2024-01-04 07:01:57.013553',NULL),(16,'IiDp1fPkIp7nh2VVnoNoWtR1c7JGXu',16,1,1,'2024-01-04 07:02:21.537774','2024-01-04 07:02:21.537774',NULL),(17,'gQC2AcS0boAIsV1N74OCJvlzP1Yx0I',17,1,1,'2024-01-04 07:04:20.547755','2024-01-04 07:04:20.547755',NULL),(18,'Hpga9W60Jj9jVkMQtHXbwYEuU3dCQR',18,1,1,'2024-01-04 07:05:08.699838','2024-01-04 07:05:08.699838',NULL),(19,'uFZEaiic1TgWn5y5fe4sGr2lzSFGJB',19,1,1,'2024-01-04 07:05:52.630836','2024-01-04 07:05:52.630836',NULL),(20,'jmHykER9V6gjZgdztbjcPcT9igbUoh',20,1,1,'2024-01-04 07:06:37.330326','2024-01-04 07:06:37.330326',NULL),(21,'2N78zUqJyWMD0LBwiPAJpry8YJOuLv',21,1,1,'2024-01-04 07:07:21.654097','2024-01-04 07:07:21.654097',NULL),(22,'gXX36TDPCbalSMfmRIPFDI7mZzFX8u',22,1,1,'2024-01-04 07:09:01.766203','2024-01-04 07:09:01.766203',NULL),(23,'KD8Q7xuS89bU2BoCqdfjTi5Mun2BMc',23,1,1,'2024-01-04 07:09:17.484983','2024-01-04 07:09:17.484983',NULL),(24,'KoLYKRw5Eb1q1HlivscaLHHbzGpJvm',24,1,1,'2024-01-04 07:10:07.071132','2024-01-04 07:10:07.071132',NULL),(25,'wtjOTlPDiCWURA7S0DL0Bvm7VSz57u',25,1,1,'2024-01-04 07:43:36.374701','2024-01-04 07:43:36.374701',NULL),(26,'geUzkmwmoDkWbXQgX7xNwveu925qIL',26,1,1,'2024-01-04 07:46:02.630306','2024-01-04 07:46:02.630306',NULL),(27,'mqMFv28AXzexQ23gAFyLYZBdKptCxb',27,1,35,'2024-01-04 08:04:35.841144','2024-01-04 08:04:35.841144',NULL),(28,'LgQfNHTwXOBRSngdwR3N1C5PhJZTI8',28,1,39,'2024-01-04 08:15:14.016402','2024-01-04 08:15:14.016402',NULL),(29,'N8XA8q1G914te1ZsKFtZyFEqtqYt9x',29,1,41,'2024-01-04 08:40:05.464527','2024-01-04 08:40:05.464527',NULL),(30,'fOs7F98jbliiltsTjaVSenA9gmyVSj',30,1,38,'2024-01-04 08:53:54.948185','2024-01-04 08:53:54.948185',NULL),(31,'akTGduQiwAEI6RhiMkIddWVJt5ZZc6',31,1,38,'2024-01-04 08:55:57.291262','2024-01-04 08:55:57.291262',NULL),(32,'Mzpyek0t2LAhGRTa266litw0Uxx2Ay',32,1,38,'2024-01-04 08:57:24.901455','2024-01-04 08:57:24.901455',NULL),(33,'eFYpuNUOCQ7vT4p8ux24CyqRoJYJs9',33,1,38,'2024-01-04 08:57:55.886345','2024-01-04 08:57:55.886345',NULL),(34,'uIZlk3OFrcXjHXLLgHOQLOriu8FtT5',34,1,1,'2024-01-04 09:17:49.281921','2024-01-04 09:17:49.281921',NULL);
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_criteria`
--

DROP TABLE IF EXISTS `thesismanagement_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_criteria` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percent` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_criteria`
--

LOCK TABLES `thesismanagement_criteria` WRITE;
/*!40000 ALTER TABLE `thesismanagement_criteria` DISABLE KEYS */;
INSERT INTO `thesismanagement_criteria` VALUES (1,'2024-01-04','2024-01-04',1,'Điểm Trình Bày',20),(2,'2024-01-04','2024-01-04',1,'Điểm Phản Biện',30),(3,'2024-01-04','2024-01-04',1,'Điểm Sản Phẩm',50);
/*!40000 ALTER TABLE `thesismanagement_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_majors`
--

DROP TABLE IF EXISTS `thesismanagement_majors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_majors` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_majors`
--

LOCK TABLES `thesismanagement_majors` WRITE;
/*!40000 ALTER TABLE `thesismanagement_majors` DISABLE KEYS */;
INSERT INTO `thesismanagement_majors` VALUES (1,'2024-01-04','2024-01-04',1,'Công Nghệ Thông Tin'),(2,'2024-01-04','2024-01-04',1,'Khoa Học Máy Tính'),(3,'2024-01-04','2024-01-04',1,'Tài Chính Ngân Hàng'),(4,'2024-01-04','2024-01-04',1,'Trí Tuệ Nhân Tạo');
/*!40000 ALTER TABLE `thesismanagement_majors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_memberofthesisdefensecommittee`
--

DROP TABLE IF EXISTS `thesismanagement_memberofthesisdefensecommittee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_memberofthesisdefensecommittee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `Committee_id` bigint NOT NULL,
  `position_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_mem_Committee_id_ff4b57cc_fk_ThesisMan` (`Committee_id`),
  KEY `ThesisManagement_mem_position_id_d8484957_fk_ThesisMan` (`position_id`),
  KEY `ThesisManagement_mem_user_id_f190f5d1_fk_ThesisMan` (`user_id`),
  CONSTRAINT `ThesisManagement_mem_Committee_id_ff4b57cc_fk_ThesisMan` FOREIGN KEY (`Committee_id`) REFERENCES `thesismanagement_thesisdefensecommittee` (`id`),
  CONSTRAINT `ThesisManagement_mem_position_id_d8484957_fk_ThesisMan` FOREIGN KEY (`position_id`) REFERENCES `thesismanagement_position` (`id`),
  CONSTRAINT `ThesisManagement_mem_user_id_f190f5d1_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_memberofthesisdefensecommittee`
--

LOCK TABLES `thesismanagement_memberofthesisdefensecommittee` WRITE;
/*!40000 ALTER TABLE `thesismanagement_memberofthesisdefensecommittee` DISABLE KEYS */;
INSERT INTO `thesismanagement_memberofthesisdefensecommittee` VALUES (1,'2024-01-04','2024-01-04',1,1,1,32),(2,'2024-01-04','2024-01-04',1,1,2,33),(3,'2024-01-04','2024-01-04',1,1,3,34),(4,'2024-01-04','2024-01-04',1,1,4,36),(5,'2024-01-04','2024-01-04',1,2,1,35),(6,'2024-01-04','2024-01-04',1,2,2,36),(7,'2024-01-04','2024-01-04',1,2,3,37),(8,'2024-01-04','2024-01-04',1,2,4,38),(9,'2024-01-04','2024-01-04',1,2,4,39),(10,'2024-01-04','2024-01-04',1,3,1,40),(11,'2024-01-04','2024-01-04',1,3,2,37),(12,'2024-01-04','2024-01-04',1,3,3,36),(13,'2024-01-04','2024-01-04',1,3,4,38),(14,'2024-01-04','2024-01-04',1,3,4,41),(15,'2024-01-04','2024-01-04',1,4,1,41),(16,'2024-01-04','2024-01-04',1,4,2,39),(17,'2024-01-04','2024-01-04',1,4,3,45),(18,'2024-01-04','2024-01-04',1,4,4,44),(19,'2024-01-04','2024-01-04',1,4,4,42);
/*!40000 ALTER TABLE `thesismanagement_memberofthesisdefensecommittee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_position`
--

DROP TABLE IF EXISTS `thesismanagement_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_position` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_position`
--

LOCK TABLES `thesismanagement_position` WRITE;
/*!40000 ALTER TABLE `thesismanagement_position` DISABLE KEYS */;
INSERT INTO `thesismanagement_position` VALUES (1,'2024-01-04','2024-01-04',1,'Chủ Tịch'),(2,'2024-01-04','2024-01-04',1,'Thư Ký'),(3,'2024-01-04','2024-01-04',1,'Phản Biện'),(4,'2024-01-04','2024-01-04',1,'Thành Viên');
/*!40000 ALTER TABLE `thesismanagement_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_role`
--

DROP TABLE IF EXISTS `thesismanagement_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_role`
--

LOCK TABLES `thesismanagement_role` WRITE;
/*!40000 ALTER TABLE `thesismanagement_role` DISABLE KEYS */;
INSERT INTO `thesismanagement_role` VALUES (1,'2024-01-04','2024-01-04',1,'admin'),(2,'2024-01-04','2024-01-04',1,'universityadministrator'),(3,'2024-01-04','2024-01-04',1,'lecturer'),(4,'2024-01-04','2024-01-04',1,'student');
/*!40000 ALTER TABLE `thesismanagement_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_score`
--

DROP TABLE IF EXISTS `thesismanagement_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_score` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `score` double NOT NULL,
  `lecturer_id` bigint DEFAULT NULL,
  `student_id` bigint DEFAULT NULL,
  `thesis_id` bigint DEFAULT NULL,
  `criteria_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_sco_thesis_id_23c8b031_fk_ThesisMan` (`thesis_id`),
  KEY `ThesisManagement_sco_criteria_id_90cf41c5_fk_ThesisMan` (`criteria_id`),
  KEY `ThesisManagement_sco_lecturer_id_e568ce22_fk_ThesisMan` (`lecturer_id`),
  KEY `ThesisManagement_sco_student_id_13cd75ee_fk_ThesisMan` (`student_id`),
  CONSTRAINT `ThesisManagement_sco_criteria_id_90cf41c5_fk_ThesisMan` FOREIGN KEY (`criteria_id`) REFERENCES `thesismanagement_criteria` (`id`),
  CONSTRAINT `ThesisManagement_sco_lecturer_id_e568ce22_fk_ThesisMan` FOREIGN KEY (`lecturer_id`) REFERENCES `thesismanagement_memberofthesisdefensecommittee` (`id`),
  CONSTRAINT `ThesisManagement_sco_student_id_13cd75ee_fk_ThesisMan` FOREIGN KEY (`student_id`) REFERENCES `thesismanagement_thesisstudent` (`id`),
  CONSTRAINT `ThesisManagement_sco_thesis_id_23c8b031_fk_ThesisMan` FOREIGN KEY (`thesis_id`) REFERENCES `thesismanagement_thesis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_score`
--

LOCK TABLES `thesismanagement_score` WRITE;
/*!40000 ALTER TABLE `thesismanagement_score` DISABLE KEYS */;
INSERT INTO `thesismanagement_score` VALUES (1,'2024-01-04','2024-01-04',1,10,1,1,1,1),(2,'2024-01-04','2024-01-04',1,9,2,1,1,2),(3,'2024-01-04','2024-01-04',1,9.5,3,1,1,3),(4,'2024-01-04','2024-01-04',1,8,4,2,1,3),(5,'2024-01-04','2024-01-04',1,8,4,2,1,2),(6,'2024-01-04','2024-01-04',1,10,3,2,1,3),(7,'2024-01-04','2024-01-04',1,10,5,3,2,1),(8,'2024-01-04','2024-01-04',1,10,5,3,2,2),(9,'2024-01-04','2024-01-04',1,10,5,3,2,3),(10,'2024-01-04','2024-01-04',1,10,6,4,2,3),(11,'2024-01-04','2024-01-04',1,9.5,6,4,2,2),(12,'2024-01-04','2024-01-04',1,9,5,4,2,3),(13,'2024-01-04','2024-01-04',1,9,6,4,2,3),(14,'2024-01-04','2024-01-04',1,7,7,4,2,2),(15,'2024-01-04','2024-01-04',1,5,7,4,2,1),(16,'2024-01-04','2024-01-04',1,5,7,4,2,1),(17,'2024-01-04','2024-01-04',1,8,14,5,3,1);
/*!40000 ALTER TABLE `thesismanagement_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_statusthesis`
--

DROP TABLE IF EXISTS `thesismanagement_statusthesis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_statusthesis` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_statusthesis`
--

LOCK TABLES `thesismanagement_statusthesis` WRITE;
/*!40000 ALTER TABLE `thesismanagement_statusthesis` DISABLE KEYS */;
INSERT INTO `thesismanagement_statusthesis` VALUES (1,'2024-01-04','2024-01-04',1,'Open'),(2,'2024-01-04','2024-01-04',1,'Close');
/*!40000 ALTER TABLE `thesismanagement_statusthesis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_thesis`
--

DROP TABLE IF EXISTS `thesismanagement_thesis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_thesis` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_id` bigint NOT NULL,
  `committee_id` bigint DEFAULT NULL,
  `major_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_the_status_id_061b7942_fk_ThesisMan` (`status_id`),
  KEY `ThesisManagement_the_committee_id_9cdfd684_fk_ThesisMan` (`committee_id`),
  KEY `ThesisManagement_the_major_id_c0d533d3_fk_ThesisMan` (`major_id`),
  CONSTRAINT `ThesisManagement_the_committee_id_9cdfd684_fk_ThesisMan` FOREIGN KEY (`committee_id`) REFERENCES `thesismanagement_thesisdefensecommittee` (`id`),
  CONSTRAINT `ThesisManagement_the_major_id_c0d533d3_fk_ThesisMan` FOREIGN KEY (`major_id`) REFERENCES `thesismanagement_majors` (`id`),
  CONSTRAINT `ThesisManagement_the_status_id_061b7942_fk_ThesisMan` FOREIGN KEY (`status_id`) REFERENCES `thesismanagement_statusthesis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesis`
--

LOCK TABLES `thesismanagement_thesis` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesis` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesis` VALUES (1,'2024-01-04','2024-01-04',1,'Phát Triển Hệ Thống Quản Lý Khóa Thuận Bằng Django Rest Framework',1,1,1),(2,'2024-01-04','2024-01-04',1,'Nghiên Cứu Về Dịch Covid-19',1,2,2),(3,'2024-01-04','2024-01-04',1,'Nghiên Cứu Về Động Đất ',1,3,4);
/*!40000 ALTER TABLE `thesismanagement_thesis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_thesisdefensecommittee`
--

DROP TABLE IF EXISTS `thesismanagement_thesisdefensecommittee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_thesisdefensecommittee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesisdefensecommittee`
--

LOCK TABLES `thesismanagement_thesisdefensecommittee` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesisdefensecommittee` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesisdefensecommittee` VALUES (1,'2024-01-04','2024-01-04',1,'Hội Đồng 1 Khóa 23-24'),(2,'2024-01-04','2024-01-04',1,'Hội Đồng 2 Khóa 23-24'),(3,'2024-01-04','2024-01-04',1,'Hội Đồng 3 Khóa 23-24'),(4,'2024-01-04','2024-01-04',1,'Hội Đồng 3 Khóa 23-24');
/*!40000 ALTER TABLE `thesismanagement_thesisdefensecommittee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_thesisexaminationcommittee`
--

DROP TABLE IF EXISTS `thesismanagement_thesisexaminationcommittee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_thesisexaminationcommittee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesisexaminationcommittee`
--

LOCK TABLES `thesismanagement_thesisexaminationcommittee` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesisexaminationcommittee` DISABLE KEYS */;
/*!40000 ALTER TABLE `thesismanagement_thesisexaminationcommittee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_thesisstudent`
--

DROP TABLE IF EXISTS `thesismanagement_thesisstudent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_thesisstudent` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `thesis_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_the_thesis_id_7b930d3f_fk_ThesisMan` (`thesis_id`),
  KEY `ThesisManagement_the_user_id_fff2900d_fk_ThesisMan` (`user_id`),
  CONSTRAINT `ThesisManagement_the_thesis_id_7b930d3f_fk_ThesisMan` FOREIGN KEY (`thesis_id`) REFERENCES `thesismanagement_thesis` (`id`),
  CONSTRAINT `ThesisManagement_the_user_id_fff2900d_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesisstudent`
--

LOCK TABLES `thesismanagement_thesisstudent` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesisstudent` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesisstudent` VALUES (1,'2024-01-04','2024-01-04',1,1,20,NULL),(2,'2024-01-04','2024-01-04',1,1,15,NULL),(3,'2024-01-04','2024-01-04',1,2,16,NULL),(4,'2024-01-04','2024-01-04',1,2,19,NULL),(5,'2024-01-04','2024-01-04',1,3,13,NULL),(6,'2024-01-04','2024-01-04',1,3,14,NULL);
/*!40000 ALTER TABLE `thesismanagement_thesisstudent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_thesissupervisor`
--

DROP TABLE IF EXISTS `thesismanagement_thesissupervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_thesissupervisor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `thesis_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_the_thesis_id_458bebd6_fk_ThesisMan` (`thesis_id`),
  KEY `ThesisManagement_the_user_id_cd273cd9_fk_ThesisMan` (`user_id`),
  CONSTRAINT `ThesisManagement_the_thesis_id_458bebd6_fk_ThesisMan` FOREIGN KEY (`thesis_id`) REFERENCES `thesismanagement_thesis` (`id`),
  CONSTRAINT `ThesisManagement_the_user_id_cd273cd9_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesissupervisor`
--

LOCK TABLES `thesismanagement_thesissupervisor` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesissupervisor` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesissupervisor` VALUES (1,'2024-01-04','2024-01-04',1,1,32),(2,'2024-01-04','2024-01-04',1,1,33),(3,'2024-01-04','2024-01-04',1,2,34),(4,'2024-01-04','2024-01-04',1,2,35),(5,'2024-01-04','2024-01-04',1,3,39),(6,'2024-01-04','2024-01-04',1,3,41);
/*!40000 ALTER TABLE `thesismanagement_thesissupervisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_user`
--

DROP TABLE IF EXISTS `thesismanagement_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `major_id` bigint DEFAULT NULL,
  `temp_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `ThesisManagement_use_major_id_d8a4c8cf_fk_ThesisMan` (`major_id`),
  CONSTRAINT `ThesisManagement_use_major_id_d8a4c8cf_fk_ThesisMan` FOREIGN KEY (`major_id`) REFERENCES `thesismanagement_majors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_user`
--

LOCK TABLES `thesismanagement_user` WRITE;
/*!40000 ALTER TABLE `thesismanagement_user` DISABLE KEYS */;
INSERT INTO `thesismanagement_user` VALUES (1,'pbkdf2_sha256$600000$Jp1SbvXNjgAQQojI3Hlyau$uBVpE796mvL949FFFzTji3F0C4JhmbndHwq8Xe0eadk=','2024-01-04 02:33:46.460095',1,'admin','','','hieu24313@gmail.com',1,1,'2024-01-04 02:28:58.192680','',NULL,'admin',NULL,NULL),(2,'pbkdf2_sha256$600000$cq0rSGbFmtSEVABowoH2pt$1RqR1tnft7KP6UFJSte/ax8e8M7we5813buNWKgy2IA=',NULL,1,'hieu','','','2051050138hieu@ou.edu.vn',1,1,'2024-01-04 02:28:58.661542','',NULL,'admin',NULL,NULL),(3,'pbkdf2_sha256$600000$GByQkRn0cJocgUgArLDGXF$9q4PAxz/yg7z4sX65Ta71OEUPtcfitu+lKX1k4fJuyw=',NULL,1,'nhu','','','2051050327nhu@ou.edu.vn',1,1,'2024-01-04 02:28:59.127572','',NULL,'admin',NULL,NULL),(4,'pbkdf2_sha256$600000$VU1h3veFFGY4zVpKuOtYB3$hvkdYEqQ85GuaFSYFlJBxt+CGwNnat5O6weooGBBj1g=',NULL,0,'giaovu','Kha','Nguyễn Minh','khanguyen@gmail.com',0,1,'2024-01-04 02:39:47.000000','image/upload/v1704336081/hqbetu0ozxelyslwstzd.jpg','0123456789','universityadministrator',NULL,NULL),(5,'pbkdf2_sha256$600000$eJurRnX4IlYpxGn67NCpH8$MyFtmnKZsI6fKeRO6owtTyOtHb60DOnSjYR/msrW5fU=',NULL,0,'giaovu2','Trí','Nguyễn Minh','tringuyen@gmail.com',0,1,'2024-01-04 02:41:38.000000','image/upload/v1704336152/uet7eejjvelz3fgj7drs.jpg',NULL,'universityadministrator',NULL,NULL),(6,'pbkdf2_sha256$600000$1udBxa7fbW8kti7rpZkzKw$PQDDdZjlpv/bV0lrIE9G9SSrsJtmrW4hj1ClAl0Cvo8=',NULL,0,'giaovu3','Nguyễn Thị','Trang','',0,1,'2024-01-04 02:44:39.000000','image/upload/v1704336323/zqk5o6w5ifsjs83dyywn.jpg',NULL,'universityadministrator',NULL,NULL),(7,'pbkdf2_sha256$600000$5CklB8EX3iE6e6KbW3cKIp$2fG7HkerGBB42vgWvCtHlQyieUt/XEhor1tG5qz2m6I=',NULL,0,'hocsinh1','','','',0,1,'2024-01-04 02:45:26.000000','image/upload/v1704336347/djlq2fol5o8gecgknxoc.jpg',NULL,'student',1,NULL),(8,'pbkdf2_sha256$600000$A6zXMjc0LSS9mnnm59Wh5H$cSsK3yvxj/OWgdpOPj3sPqIgTRBJQB7KHbEoGtsLQws=',NULL,0,'sinhvien2','','','',0,1,'2024-01-04 02:45:48.000000','image/upload/v1704336366/z6ys2bxu0c23231jfqv5.jpg',NULL,'student',1,NULL),(9,'pbkdf2_sha256$600000$YhlZubqdDv990Niw1jH8vD$5KXgVhBmF58WQt39N7OWB+2ZNwtMIQE4bbNbXfIHMFQ=',NULL,0,'sinhvien3','','','',0,1,'2024-01-04 02:46:07.000000','image/upload/v1704336385/r0cs5bjnwfqx0urdnk65.jpg',NULL,'student',2,NULL),(10,'pbkdf2_sha256$600000$C4bJlkaVgozTtN8db1ey4T$7Fs0v0ngCdYbnT2/H8Wy/kVU6LUc+sq+DH3ooDhfOzI=',NULL,0,'sinhvien4','','','',0,1,'2024-01-04 02:46:26.000000','image/upload/v1704336399/uu0oy378af0zmdbsjyn3.jpg',NULL,'student',2,NULL),(11,'pbkdf2_sha256$600000$BersrwGRdNMRbXQDZJMe01$+PRBlj31N4eiKg9IR9K07UQGJjd5/9fgPqqdAdaz04I=',NULL,0,'sinhvien5','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:52.833710',NULL,NULL,'student',3,NULL),(12,'pbkdf2_sha256$600000$IIi6htZEef8Xo5PaTRsiZl$MXQMy4Ec8DXCGhKdsdvC9hEfec516viostxVM4F1whI=',NULL,0,'sinhvien6','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:53.296974',NULL,NULL,'student',3,NULL),(13,'pbkdf2_sha256$600000$mwLmALOqaeva9TztpnhO26$xwHSg6HuyNulKcSHdopV5jmCXZMxhfDztaZCPaDvUvU=',NULL,0,'sinhvien7','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:53.809451',NULL,NULL,'student',4,NULL),(14,'pbkdf2_sha256$600000$8TxkgSnphVcNadRNF6CK0D$8RD0w4JjQKANU4X2We1whTpu6b0FKRop4fbyrnXd+Gw=',NULL,0,'sinhvien8','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:54.285416',NULL,NULL,'student',4,NULL),(15,'pbkdf2_sha256$600000$VG9kmAeJVaK7o4wr2zMmft$xkdxVYibJHN1p429U5AwQi49GUAC/altm8KiPT96cEc=',NULL,0,'sinhvien9','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:54.770311',NULL,NULL,'student',1,NULL),(16,'pbkdf2_sha256$600000$FEFoO1TueyrG3AuekOJepS$g/i3WbvvHJOTqWF6A7bpWiaMHHVPBUFeOONpYzBzCVE=',NULL,0,'sinhvien10','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:55.244357',NULL,NULL,'student',2,NULL),(17,'pbkdf2_sha256$600000$GjgrJpfkmwTQr2HdLg0XGY$tiUuYIff27A0ImoZ4qqDdneNyE77Cud2fDQ6BHu0bok=',NULL,0,'sinhvien11','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:55.722293',NULL,NULL,'student',4,NULL),(18,'pbkdf2_sha256$600000$pXQj8PxbIDxi2Fpxb2xzTf$O7sKiRip6lkJQg5Oj1R7bYKbzlK6HkQyzzQjEEFSsgg=',NULL,0,'sinhvien12','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:56.193317',NULL,NULL,'student',3,NULL),(19,'pbkdf2_sha256$600000$dfXZMWbz0Hoh7Z4vdIEcXw$FNgG1T/vthSmEJEnkaEfC0n6QOuCpaVjlaaacJzU4/c=',NULL,0,'sinhvien13','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:56.681876',NULL,NULL,'student',2,NULL),(20,'pbkdf2_sha256$600000$PpoKzwcvNNqInqsl9YE1cN$tsSTwpk430h7KlyQzqpOpGzWRdVkbGpuhIZGyZqmLVc=',NULL,0,'sinhvien14','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:57.150838',NULL,NULL,'student',1,NULL),(21,'pbkdf2_sha256$600000$aIDrNZOjTHjytXqcABOrNr$HHdUE6rNl9BkLWWol2sCEvNScPbUVzWMmktE6K9A3wA=',NULL,0,'giaovu4','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:57.624724',NULL,NULL,'universityadministrator',NULL,NULL),(22,'pbkdf2_sha256$600000$q2Z1BjdJtbIct2e4PkOCBS$mZldkBsk8tuejofkObKxKOcNl0Dl6XNVoquCFShj9Co=',NULL,0,'giaovu5','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:58.089124',NULL,NULL,'universityadministrator',NULL,NULL),(23,'pbkdf2_sha256$600000$6jHgcnEK1sWuawvYCiHskK$PhT7TuTKoTVKfjF9sy6wD/UfVbYp1buhRp2UwsKFTI4=',NULL,0,'giaovu6','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:58.552919',NULL,NULL,'universityadministrator',NULL,NULL),(24,'pbkdf2_sha256$600000$2xxvxHlQhJqDjG3emIQGHD$uf8FASaA+jBZN04RnNF9beOo02ETEIE+CS6wep4F2Gk=',NULL,0,'giaovu7','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:59.023826',NULL,NULL,'universityadministrator',NULL,NULL),(25,'pbkdf2_sha256$600000$j2BRlRjc9yAMCeim2MdXsU$/GtZBv3rpv/9GGdKAWndon2WH2BVzbZXpfh5+OTfZao=',NULL,0,'giaovu8','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:59.487946',NULL,NULL,'universityadministrator',NULL,NULL),(26,'pbkdf2_sha256$600000$PEHJLLtx9WFyNMKiCjElea$KSfFYRHZIDeNsJdKrYbuSoHNmDJfjPnTtcDEK4WC6KQ=',NULL,0,'giaovu9','','','hieu24313@gmail.com',0,1,'2024-01-04 02:52:59.951576',NULL,NULL,'universityadministrator',NULL,NULL),(27,'pbkdf2_sha256$600000$IAa8mc8Tl2Tiujfu7l00tS$eE6MZTv+oxrsnDgPussduVHZrkj7r9+bA6ibGxLalko=',NULL,0,'giaovu10','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:00.423247',NULL,NULL,'universityadministrator',NULL,NULL),(28,'pbkdf2_sha256$600000$BWMu0RhaAeO3oqmv8avgKy$K89tJv1Kq5t334hpbXh8TGzQEEr0JcxhDVukgG2I8JQ=',NULL,0,'giaovu11','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:01.497493',NULL,NULL,'universityadministrator',NULL,NULL),(29,'pbkdf2_sha256$600000$havOCoeaJUENO97ihGUulI$Josgx+R7Of6/a40aqrsYCA1+Jw9cd77avCKGKUxwnx4=',NULL,0,'giaovu12','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:02.259918',NULL,NULL,'universityadministrator',NULL,NULL),(30,'pbkdf2_sha256$600000$sKjKmenXBVMsBB2GaSDq8A$g509wjz0/Rk10fe9IxaVaDygyL6NI48PHAYSHWOdqxY=',NULL,0,'giaovu13','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:02.729273',NULL,NULL,'universityadministrator',NULL,NULL),(31,'pbkdf2_sha256$600000$mhSppX0B4lqhXPKVlpbewz$cz9a4WIggsF+Mu/jfRBbp+xzf77HPnLJujNPXmc/u/Y=',NULL,0,'giaovu14','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:03.198224',NULL,NULL,'universityadministrator',NULL,NULL),(32,'pbkdf2_sha256$600000$uAxBN8iDcpLebmIyf6qaH6$9bpbNKZHHyO+HkU9BTEVmr75ZRUc/jg0c4feP27LKEY=',NULL,0,'giangvien1','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:03.691741',NULL,NULL,'lecturer',NULL,NULL),(33,'pbkdf2_sha256$600000$hTy8aLnku0zf2mXe9mRb1j$Kwsngu5WSxAgG2UBmcUhKJIOBDFEoHLH9ld9HGD1afI=',NULL,0,'giangvien2','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:04.202368',NULL,NULL,'lecturer',NULL,NULL),(34,'pbkdf2_sha256$600000$w155ilIXP1JSk6b64j5Aey$HMqxSba6GEMlBkAQ7bQUjsrcSse3lcHKUmZOP7EHgYs=',NULL,0,'giangvien3','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:04.681175',NULL,NULL,'lecturer',NULL,NULL),(35,'pbkdf2_sha256$600000$enjGimgqUgY3CgLbQ0HqaV$kXbb+bobnhFJB8325Qq4+jzK5snOMbT9oUbxLeQq9+E=',NULL,0,'giangvien4','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:05.149636',NULL,NULL,'lecturer',NULL,NULL),(36,'pbkdf2_sha256$600000$P8pkRIqwPuSpBsY1cW0AsY$sqKKdBoDPcTrM1RNnWoaHNx0KI6cPTUxnzwD5EUnVW0=',NULL,0,'giangvien5','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:05.631845',NULL,NULL,'lecturer',NULL,NULL),(37,'pbkdf2_sha256$600000$DcftyblJmNII0eu2YmdaV3$m5ZhwzNxwSvIwlf8PUxGIgufpVQsXJGCLBlTMsrosBw=',NULL,0,'giangvien6','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:06.121124',NULL,NULL,'lecturer',NULL,NULL),(38,'pbkdf2_sha256$600000$2LKTMc45gZtXkhBWoGYA8M$52gwuUtjfcQJY4HErSk72nJ2JSNNsg/MZ5UG/CdGj2I=',NULL,0,'giangvien7','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:06.588421',NULL,NULL,'lecturer',NULL,NULL),(39,'pbkdf2_sha256$600000$niviNKPi7fybfNxbn4gC1b$quy2arM9syC4BtjnDJvMfh3TGrrt9ubkRdfBXZz++Eg=',NULL,0,'giangvien8','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:07.066378',NULL,NULL,'lecturer',NULL,NULL),(40,'pbkdf2_sha256$600000$6LyDKfH7izTZIbgPlDiQWW$iKwpZDlCnUwB0SHLIXfUCD7hKNk4P2FWdLbbpV1DvAM=',NULL,0,'giangvien9','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:07.528106',NULL,NULL,'lecturer',NULL,NULL),(41,'pbkdf2_sha256$600000$Xx0VIP4P7xqjhxNnhgp9Ho$RIXixy2AUaB/YkXZrwvBlrN7sHtWVNREO9BIHD2Q04c=',NULL,0,'giangvien10','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:07.994444',NULL,NULL,'lecturer',NULL,NULL),(42,'pbkdf2_sha256$600000$XCNnR4tdVNaOOjZap7D73o$3JB2AKdb285poYRn/Q6se+09IYIovOHgnGs/uCt/xaw=',NULL,0,'giangvien11','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:09.042575',NULL,NULL,'lecturer',NULL,NULL),(43,'pbkdf2_sha256$600000$FmO4bW0hfNYa4rCNwZdC2N$F/lkPwj8H+QfF2ZBaOo3tQxgcT4be+JB8Z2zDArWvhY=',NULL,0,'giangvien12','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:09.818432',NULL,NULL,'lecturer',NULL,NULL),(44,'pbkdf2_sha256$600000$fMFZn4KhsvqbE0o0wC3EUm$t1v1dnDbOawVBfoAslFaIcRPxNpPLSATUPMqo52p6jE=',NULL,0,'giangvien13','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:10.286582',NULL,NULL,'lecturer',NULL,NULL),(45,'pbkdf2_sha256$600000$ULNG2eFzAYxaZZf0qowrcy$zLrPtET3QMlWPQlnMep5ZBelnrbfcCOneZrFqbAjpGk=',NULL,0,'giangvien14','','','hieu24313@gmail.com',0,1,'2024-01-04 02:53:10.832178',NULL,NULL,'lecturer',NULL,NULL);
/*!40000 ALTER TABLE `thesismanagement_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_user_groups`
--

DROP TABLE IF EXISTS `thesismanagement_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ThesisManagement_user_groups_user_id_group_id_8a23f872_uniq` (`user_id`,`group_id`),
  KEY `ThesisManagement_user_groups_group_id_b5c42a66_fk_auth_group_id` (`group_id`),
  CONSTRAINT `ThesisManagement_use_user_id_ba39fc98_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`),
  CONSTRAINT `ThesisManagement_user_groups_group_id_b5c42a66_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_user_groups`
--

LOCK TABLES `thesismanagement_user_groups` WRITE;
/*!40000 ALTER TABLE `thesismanagement_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `thesismanagement_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_user_user_permissions`
--

DROP TABLE IF EXISTS `thesismanagement_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ThesisManagement_user_us_user_id_permission_id_e9a85c72_uniq` (`user_id`,`permission_id`),
  KEY `ThesisManagement_use_permission_id_0e66913d_fk_auth_perm` (`permission_id`),
  CONSTRAINT `ThesisManagement_use_permission_id_0e66913d_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `ThesisManagement_use_user_id_51c19d59_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_user_user_permissions`
--

LOCK TABLES `thesismanagement_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `thesismanagement_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `thesismanagement_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-04 16:32:47
