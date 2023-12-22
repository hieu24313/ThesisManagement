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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'admin');
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
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add criteria',7,'add_criteria'),(26,'Can change criteria',7,'change_criteria'),(27,'Can delete criteria',7,'delete_criteria'),(28,'Can view criteria',7,'view_criteria'),(29,'Can add member of thesis defense committee',8,'add_memberofthesisdefensecommittee'),(30,'Can change member of thesis defense committee',8,'change_memberofthesisdefensecommittee'),(31,'Can delete member of thesis defense committee',8,'delete_memberofthesisdefensecommittee'),(32,'Can view member of thesis defense committee',8,'view_memberofthesisdefensecommittee'),(33,'Can add position',9,'add_position'),(34,'Can change position',9,'change_position'),(35,'Can delete position',9,'delete_position'),(36,'Can view position',9,'view_position'),(37,'Can add status thesis',10,'add_statusthesis'),(38,'Can change status thesis',10,'change_statusthesis'),(39,'Can delete status thesis',10,'delete_statusthesis'),(40,'Can view status thesis',10,'view_statusthesis'),(41,'Can add thesis',11,'add_thesis'),(42,'Can change thesis',11,'change_thesis'),(43,'Can delete thesis',11,'delete_thesis'),(44,'Can view thesis',11,'view_thesis'),(45,'Can add thesis defense committee',12,'add_thesisdefensecommittee'),(46,'Can change thesis defense committee',12,'change_thesisdefensecommittee'),(47,'Can delete thesis defense committee',12,'delete_thesisdefensecommittee'),(48,'Can view thesis defense committee',12,'view_thesisdefensecommittee'),(49,'Can add thesis supervisor',13,'add_thesissupervisor'),(50,'Can change thesis supervisor',13,'change_thesissupervisor'),(51,'Can delete thesis supervisor',13,'delete_thesissupervisor'),(52,'Can view thesis supervisor',13,'view_thesissupervisor'),(53,'Can add thesis student',14,'add_thesisstudent'),(54,'Can change thesis student',14,'change_thesisstudent'),(55,'Can delete thesis student',14,'delete_thesisstudent'),(56,'Can view thesis student',14,'view_thesisstudent'),(57,'Can add thesis examination committee',15,'add_thesisexaminationcommittee'),(58,'Can change thesis examination committee',15,'change_thesisexaminationcommittee'),(59,'Can delete thesis examination committee',15,'delete_thesisexaminationcommittee'),(60,'Can view thesis examination committee',15,'view_thesisexaminationcommittee'),(61,'Can add score',16,'add_score'),(62,'Can change score',16,'change_score'),(63,'Can delete score',16,'delete_score'),(64,'Can view score',16,'view_score'),(65,'Can add role',17,'add_role'),(66,'Can change role',17,'change_role'),(67,'Can delete role',17,'delete_role'),(68,'Can view role',17,'view_role'),(69,'Can add application',18,'add_application'),(70,'Can change application',18,'change_application'),(71,'Can delete application',18,'delete_application'),(72,'Can view application',18,'view_application'),(73,'Can add access token',19,'add_accesstoken'),(74,'Can change access token',19,'change_accesstoken'),(75,'Can delete access token',19,'delete_accesstoken'),(76,'Can view access token',19,'view_accesstoken'),(77,'Can add grant',20,'add_grant'),(78,'Can change grant',20,'change_grant'),(79,'Can delete grant',20,'delete_grant'),(80,'Can view grant',20,'view_grant'),(81,'Can add refresh token',21,'add_refreshtoken'),(82,'Can change refresh token',21,'change_refreshtoken'),(83,'Can delete refresh token',21,'delete_refreshtoken'),(84,'Can view refresh token',21,'view_refreshtoken'),(85,'Can add id token',22,'add_idtoken'),(86,'Can change id token',22,'change_idtoken'),(87,'Can delete id token',22,'delete_idtoken'),(88,'Can view id token',22,'view_idtoken');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-12-22 08:10:56.900478','5',' ',1,'[{\"added\": {}}]',6,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(19,'oauth2_provider','accesstoken'),(18,'oauth2_provider','application'),(20,'oauth2_provider','grant'),(22,'oauth2_provider','idtoken'),(21,'oauth2_provider','refreshtoken'),(5,'sessions','session'),(7,'ThesisManagement','criteria'),(8,'ThesisManagement','memberofthesisdefensecommittee'),(9,'ThesisManagement','position'),(17,'ThesisManagement','role'),(16,'ThesisManagement','score'),(10,'ThesisManagement','statusthesis'),(11,'ThesisManagement','thesis'),(12,'ThesisManagement','thesisdefensecommittee'),(15,'ThesisManagement','thesisexaminationcommittee'),(14,'ThesisManagement','thesisstudent'),(13,'ThesisManagement','thesissupervisor'),(6,'ThesisManagement','user');
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-12-05 06:12:00.080028'),(2,'contenttypes','0002_remove_content_type_name','2023-12-05 06:12:00.119517'),(3,'auth','0001_initial','2023-12-05 06:12:00.253198'),(4,'auth','0002_alter_permission_name_max_length','2023-12-05 06:12:00.290239'),(5,'auth','0003_alter_user_email_max_length','2023-12-05 06:12:00.296760'),(6,'auth','0004_alter_user_username_opts','2023-12-05 06:12:00.302626'),(7,'auth','0005_alter_user_last_login_null','2023-12-05 06:12:00.313738'),(8,'auth','0006_require_contenttypes_0002','2023-12-05 06:12:00.316747'),(9,'auth','0007_alter_validators_add_error_messages','2023-12-05 06:12:00.323727'),(10,'auth','0008_alter_user_username_max_length','2023-12-05 06:12:00.331704'),(11,'auth','0009_alter_user_last_name_max_length','2023-12-05 06:12:00.338434'),(12,'auth','0010_alter_group_name_max_length','2023-12-05 06:12:00.352376'),(13,'auth','0011_update_proxy_permissions','2023-12-05 06:12:00.361946'),(14,'auth','0012_alter_user_first_name_max_length','2023-12-05 06:12:00.367934'),(15,'ThesisManagement','0001_initial','2023-12-05 06:12:00.927059'),(16,'ThesisManagement','0002_user_avatar_user_phone_alter_criteria_name_and_more','2023-12-05 06:12:01.091219'),(17,'ThesisManagement','0003_delete_criteria_and_more','2023-12-05 06:12:01.665904'),(18,'ThesisManagement','0004_alter_user_groups_alter_user_user_permissions','2023-12-05 06:12:01.677257'),(19,'ThesisManagement','0005_criteria_memberofthesisdefensecommittee_position_and_more','2023-12-05 06:12:02.135075'),(20,'ThesisManagement','0006_alter_user_groups_alter_user_user_permissions','2023-12-05 06:12:02.154027'),(21,'ThesisManagement','0007_score_thesis','2023-12-05 06:12:02.195103'),(22,'ThesisManagement','0008_alter_user_avatar_alter_user_phone','2023-12-05 06:12:02.212076'),(23,'ThesisManagement','0009_user_role','2023-12-05 06:12:02.261698'),(24,'ThesisManagement','0010_role_alter_user_role','2023-12-05 06:12:02.403252'),(25,'ThesisManagement','0011_alter_user_role','2023-12-05 06:12:02.523494'),(26,'ThesisManagement','0012_alter_user_role','2023-12-05 06:12:02.564906'),(27,'ThesisManagement','0013_alter_user_role','2023-12-05 06:12:02.575356'),(28,'admin','0001_initial','2023-12-05 06:12:02.649008'),(29,'admin','0002_logentry_remove_auto_add','2023-12-05 06:12:02.660980'),(30,'admin','0003_logentry_add_action_flag_choices','2023-12-05 06:12:02.670956'),(31,'oauth2_provider','0001_initial','2023-12-05 06:12:03.060890'),(32,'oauth2_provider','0002_auto_20190406_1805','2023-12-05 06:12:03.115016'),(33,'oauth2_provider','0003_auto_20201211_1314','2023-12-05 06:12:03.162394'),(34,'oauth2_provider','0004_auto_20200902_2022','2023-12-05 06:12:03.411589'),(35,'oauth2_provider','0005_auto_20211222_2352','2023-12-05 06:12:03.485384'),(36,'oauth2_provider','0006_alter_application_client_secret','2023-12-05 06:12:03.514073'),(37,'oauth2_provider','0007_application_post_logout_redirect_uris','2023-12-05 06:12:03.577918'),(38,'sessions','0001_initial','2023-12-05 06:12:03.602541'),(39,'ThesisManagement','0014_alter_user_role','2023-12-05 07:14:50.016006'),(40,'ThesisManagement','0015_remove_thesisexaminationcommittee_committee_and_more','2023-12-09 02:51:22.057628'),(41,'ThesisManagement','0016_thesis_status','2023-12-12 01:04:54.142115'),(42,'ThesisManagement','0017_remove_thesisdefensecommittee_thesis_and_more','2023-12-22 08:43:35.676496'),(43,'ThesisManagement','0018_remove_thesis_committee_thesis_committee','2023-12-22 09:10:55.959661');
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
INSERT INTO `django_session` VALUES ('28z5z2tpic7jcq11ve7cqaqzcxmzdc33','.eJxVjDsOwjAQBe_iGlnZ9ScOJT1nsJz1Lg4gR4qTCnF3iJQC2jcz76Vi2tYSt8ZLnLI6K1Cn321M9OC6g3xP9TZrmuu6TKPeFX3Qpq9z5uflcP8OSmrlW4dMvbMi6JwY6YStNwkDk2QCCoDeG4cDICIMwGQZJXnoxHDvwVj1_gDmqjdv:1rGac4:JLSCTMWWy_LuSPqOWdmugXNx3nwi6mBp0A-KYKQn5Q0','2024-01-05 08:10:32.688719'),('8ebdgsx1bv4d8q4sh3fol8o9oh1vikf9','.eJxVjDsOwjAQBe_iGlnZ9ScOJT1nsJz1Lg4gR4qTCnF3iJQC2jcz76Vi2tYSt8ZLnLI6K1Cn321M9OC6g3xP9TZrmuu6TKPeFX3Qpq9z5uflcP8OSmrlW4dMvbMi6JwY6YStNwkDk2QCCoDeG4cDICIMwGQZJXnoxHDvwVj1_gDmqjdv:1rAOrL:tnsXoxVoJYhH3a-RgfyRLrJKOvCxiy739W_wae0zd2M','2023-12-19 06:24:43.268898');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'91IP9iWQc2q9e6m6IBjrBWxys1C7mH','2023-12-05 16:32:16.660543','read write',1,1,'2023-12-05 06:32:16.660543','2023-12-05 06:32:16.660543',NULL,NULL),(2,'3LFxuJnwUxhnAvqqtPDuin2bOeMZFM','2023-12-05 23:16:13.687093','read write',1,1,'2023-12-05 13:16:13.689079','2023-12-05 13:16:13.689079',NULL,NULL),(3,'PGMaAgvizRNm6LKwB7z9kMPANBjTMz','2023-12-08 16:46:04.607306','read write',1,1,'2023-12-08 06:46:04.609093','2023-12-08 06:46:04.609093',NULL,NULL),(4,'W4LXLaX112aqvWQNbaFtlhIvCMsRK5','2023-12-09 13:11:50.073860','read write',1,1,'2023-12-09 03:11:50.074858','2023-12-09 03:11:50.074858',NULL,NULL),(5,'U0WdauBIjyS4qOOpX8vRGWqJJuAYl6','2023-12-13 23:11:08.567979','read write',1,1,'2023-12-13 13:11:08.568974','2023-12-13 13:11:08.568974',NULL,NULL),(6,'y0EhNNarwdC6y4CxNqdygIBoFsuZW2','2023-12-13 23:12:35.027790','read write',1,1,'2023-12-13 13:12:35.027790','2023-12-13 13:12:35.027790',NULL,NULL),(7,'gXvEHrs02neygvLbmAuZidENhySJz3','2023-12-13 23:46:50.168910','read write',1,1,'2023-12-13 13:46:50.169908','2023-12-13 13:46:50.169908',NULL,NULL),(8,'JMDbyceFyrURXzzbOEMmpTFB8VDuJ7','2023-12-14 00:43:15.791604','read write',1,1,'2023-12-13 14:43:15.791604','2023-12-13 14:43:15.791604',NULL,NULL),(9,'qi0pJAmUBcz1FGAiAks51vNN6p5SYE','2023-12-14 00:43:41.743355','read write',1,1,'2023-12-13 14:43:41.743355','2023-12-13 14:43:41.743355',NULL,NULL),(10,'bsXBqpnWdTCoCd5g126LKXMKnqgJkc','2023-12-14 00:52:02.160236','read write',1,1,'2023-12-13 14:52:02.160236','2023-12-13 14:52:02.160236',NULL,NULL),(11,'LMs608q8poj6HmOJTC38P8UHMynYoL','2023-12-14 00:54:05.223790','read write',1,2,'2023-12-13 14:54:05.223790','2023-12-13 14:54:05.223790',NULL,NULL),(12,'nx9bhPahwIvrQXneuiSaOoPBWAJu5n','2023-12-14 00:54:56.614695','read write',1,2,'2023-12-13 14:54:56.614695','2023-12-13 14:54:56.614695',NULL,NULL),(13,'zs0eycGutyhk7aoLueiVgmKMazoYAi','2023-12-14 00:56:31.444591','read write',1,2,'2023-12-13 14:56:31.444591','2023-12-13 14:56:31.444591',NULL,NULL),(14,'hXPhCYWqfXJqHnwv1rRSvb2fYCRW3i','2023-12-14 00:57:15.616388','read write',1,2,'2023-12-13 14:57:15.616388','2023-12-13 14:57:15.616388',NULL,NULL),(15,'3y8hT84pfg4kdMqNhHeF59M0Gu18As','2023-12-14 00:57:28.824506','read write',1,2,'2023-12-13 14:57:28.824506','2023-12-13 14:57:28.824506',NULL,NULL),(16,'6TYDcvCp4km7BQPxVejx1WNWKwmQNN','2023-12-14 00:57:40.395907','read write',1,2,'2023-12-13 14:57:40.396939','2023-12-13 14:57:40.396939',NULL,NULL),(17,'VytEv4NKqSH32UDld35gmbtNrjOvyD','2023-12-14 01:01:01.728521','read write',1,2,'2023-12-13 15:01:01.728521','2023-12-13 15:01:01.728521',NULL,NULL),(18,'MinAXzE0PnQEYwidhsBFGvDbvbpu6d','2023-12-14 01:04:01.895674','read write',1,2,'2023-12-13 15:04:01.896683','2023-12-13 15:04:01.896683',NULL,NULL),(19,'Cl0PrFQv4vtzgfz8GVrPpW3srHdeNb','2023-12-14 01:04:54.444744','read write',1,2,'2023-12-13 15:04:54.444744','2023-12-13 15:04:54.444744',NULL,NULL),(20,'kbn9ELLh0OYFFCcEvhQnnIkruViwlU','2023-12-14 01:04:56.318579','read write',1,2,'2023-12-13 15:04:56.318579','2023-12-13 15:04:56.318579',NULL,NULL),(21,'jDijndE7K3ruWTfYUVwjg4q9L0WkQZ','2023-12-22 18:08:48.185702','read write',1,1,'2023-12-22 08:08:48.186693','2023-12-22 08:08:48.186693',NULL,NULL),(22,'lXws66OfduAVoDcNBLeni6Gr0b9fxU','2023-12-22 18:11:13.236094','read write',1,5,'2023-12-22 08:11:13.236094','2023-12-22 08:11:13.236094',NULL,NULL),(23,'lBjYRFUeYmVw0Yy3Kv9d5JLFjoi3mq','2023-12-22 18:18:32.423972','read write',1,5,'2023-12-22 08:18:32.423972','2023-12-22 08:18:32.423972',NULL,NULL),(24,'UDZlkMHcZSWj8Wuh8fRQRRzFJjdEgF','2023-12-22 18:18:44.012661','read write',1,5,'2023-12-22 08:18:44.013707','2023-12-22 08:18:44.013707',NULL,NULL);
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
INSERT INTO `oauth2_provider_application` VALUES (1,'E6qkqMboLiY269L4dwciPOvoaW6m4drb7KyxvjB6','','confidential','password','pbkdf2_sha256$600000$x4k3kgOQ1lwc3NahVtj2Qr$NnN1Jt+IRIP4xHNDElRK1npGAxwC2yzY0smhaMZjQcU=','Thesis Management',1,0,'2023-12-05 06:26:10.597550','2023-12-05 06:26:10.597550','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'VFgH8slDr34MGMmOxyaumH2qhn1PwF',1,1,1,'2023-12-05 06:32:16.663286','2023-12-05 06:32:16.663286',NULL),(2,'5NJEZ4q8i0FGpowvSWtRitswAnWBBr',2,1,1,'2023-12-05 13:16:13.708777','2023-12-05 13:16:13.709828',NULL),(3,'AMVOUmMUxCC2G848VgxevGs2ysigIw',3,1,1,'2023-12-08 06:46:04.631405','2023-12-08 06:46:04.631405',NULL),(4,'tTDO7YxpGAoiFd8DnlaaOJLM9s7hJq',4,1,1,'2023-12-09 03:11:50.085826','2023-12-09 03:11:50.085826',NULL),(5,'K49D1gnmKrvVvgvzvn3IWqf18UuVF0',5,1,1,'2023-12-13 13:11:08.586829','2023-12-13 13:11:08.586829',NULL),(6,'BUygZNhPfGL2scUJcX5mw9vA0O3ukw',6,1,1,'2023-12-13 13:12:35.042694','2023-12-13 13:12:35.042694',NULL),(7,'a96wBHPjPvjV47wdqgIWE8dCl1IXJ5',7,1,1,'2023-12-13 13:46:50.175836','2023-12-13 13:46:50.175836',NULL),(8,'6snS3xEWytVpx2jGf5bDxoH57noDIw',8,1,1,'2023-12-13 14:43:15.807807','2023-12-13 14:43:15.807807',NULL),(9,'bTgEwGXuBu3H4ME2POWZTYO2yXp3tm',9,1,1,'2023-12-13 14:43:41.751592','2023-12-13 14:43:41.751592',NULL),(10,'QIHmqvDEXILyHGsDHwYkrHWQ44mLBM',10,1,1,'2023-12-13 14:52:02.170299','2023-12-13 14:52:02.170299',NULL),(11,'bWOFrVXMS9ontBMTKc3tjt5AishSEY',11,1,2,'2023-12-13 14:54:05.233994','2023-12-13 14:54:05.233994',NULL),(12,'pGTNUy2v9AXMdw6PlsYxubprZH6lRU',12,1,2,'2023-12-13 14:54:56.623337','2023-12-13 14:54:56.623337',NULL),(13,'nPvGdRQHjumYnJ4qHhfxCKWjgFXXrl',13,1,2,'2023-12-13 14:56:31.454216','2023-12-13 14:56:31.454216',NULL),(14,'YhUKRDYgNdYyI2jkNczLz16FB6XvIB',14,1,2,'2023-12-13 14:57:15.621440','2023-12-13 14:57:15.621440',NULL),(15,'kRY5D5gOLHTyTbZQCw3NIBOySEvbCI',15,1,2,'2023-12-13 14:57:28.828637','2023-12-13 14:57:28.828637',NULL),(16,'OtBamBjRuzHn3xr6CXsrUJuDDk8kyO',16,1,2,'2023-12-13 14:57:40.406051','2023-12-13 14:57:40.406051',NULL),(17,'e6HuYXZXSzc5vxnUjRmp33Mo2WK6Qj',17,1,2,'2023-12-13 15:01:01.731639','2023-12-13 15:01:01.731639',NULL),(18,'UBDhQXf6rIp0wSaXN32GQMNkNqDfE4',18,1,2,'2023-12-13 15:04:01.900339','2023-12-13 15:04:01.900339',NULL),(19,'qWIDGqo6fixKEtMZVFSjoyKRT22d6S',19,1,2,'2023-12-13 15:04:54.446766','2023-12-13 15:04:54.446766',NULL),(20,'VoMD8V4SMPm0BBHsd4oPfH7aIiOiOt',20,1,2,'2023-12-13 15:04:56.322821','2023-12-13 15:04:56.322821',NULL),(21,'bsrchTOVfBHTXySB61dAWm9V7gu8GD',21,1,1,'2023-12-22 08:08:48.247757','2023-12-22 08:08:48.247757',NULL),(22,'rwsS5eL2Gja55ZcY33JDirgsiWYiex',22,1,5,'2023-12-22 08:11:13.238128','2023-12-22 08:11:13.238128',NULL),(23,'WqKLkLjv3wHjKwwdYMMq4SIW0RzMad',23,1,5,'2023-12-22 08:18:32.428411','2023-12-22 08:18:32.428411',NULL),(24,'JS7aEiYej0FzlgIjRy7v1uIzYMdWBQ',24,1,5,'2023-12-22 08:18:44.014708','2023-12-22 08:18:44.014708',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_criteria`
--

LOCK TABLES `thesismanagement_criteria` WRITE;
/*!40000 ALTER TABLE `thesismanagement_criteria` DISABLE KEYS */;
INSERT INTO `thesismanagement_criteria` VALUES (1,'2023-12-05','2023-12-05',1,'Cuối Kỳ',50),(2,'2023-12-05','2023-12-05',1,'Giữa Kỳ',50),(7,'2023-12-22','2023-12-22',1,'Điểm Đạo Văn 1',20);
/*!40000 ALTER TABLE `thesismanagement_criteria` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_memberofthesisdefensecommittee`
--

LOCK TABLES `thesismanagement_memberofthesisdefensecommittee` WRITE;
/*!40000 ALTER TABLE `thesismanagement_memberofthesisdefensecommittee` DISABLE KEYS */;
INSERT INTO `thesismanagement_memberofthesisdefensecommittee` VALUES (1,'2023-12-14','2023-12-14',1,1,1,2),(2,'2023-12-14','2023-12-14',1,2,1,3),(3,'2023-12-14','2023-12-14',1,2,1,3),(4,'2023-12-14','2023-12-14',1,1,1,1),(5,'2023-12-14','2023-12-14',0,2,1,1),(6,'2023-12-14','2023-12-14',0,2,1,1);
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
INSERT INTO `thesismanagement_position` VALUES (1,'2023-12-05','2023-12-05',1,'Chủ Tịch'),(2,'2023-12-05','2023-12-05',1,'Thư Ký'),(3,'2023-12-05','2023-12-05',1,'Phản Biện'),(4,'2023-12-05','2023-12-05',1,'Thành Viên');
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
INSERT INTO `thesismanagement_role` VALUES (1,'2023-12-05','2023-12-05',1,'admin'),(2,'2023-12-05','2023-12-05',1,'universityadministrator'),(3,'2023-12-05','2023-12-05',1,'lecturer'),(4,'2023-12-05','2023-12-05',1,'student');
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
  `memberofcommittee_id` bigint NOT NULL,
  `scoreofstudent_id` bigint NOT NULL,
  `thesis_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_sco_memberofcommittee_id_31665153_fk_ThesisMan` (`memberofcommittee_id`),
  KEY `ThesisManagement_sco_scoreofstudent_id_b13b609b_fk_ThesisMan` (`scoreofstudent_id`),
  KEY `ThesisManagement_sco_thesis_id_23c8b031_fk_ThesisMan` (`thesis_id`),
  CONSTRAINT `ThesisManagement_sco_memberofcommittee_id_31665153_fk_ThesisMan` FOREIGN KEY (`memberofcommittee_id`) REFERENCES `thesismanagement_memberofthesisdefensecommittee` (`id`),
  CONSTRAINT `ThesisManagement_sco_scoreofstudent_id_b13b609b_fk_ThesisMan` FOREIGN KEY (`scoreofstudent_id`) REFERENCES `thesismanagement_thesisstudent` (`id`),
  CONSTRAINT `ThesisManagement_sco_thesis_id_23c8b031_fk_ThesisMan` FOREIGN KEY (`thesis_id`) REFERENCES `thesismanagement_thesis` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_score`
--

LOCK TABLES `thesismanagement_score` WRITE;
/*!40000 ALTER TABLE `thesismanagement_score` DISABLE KEYS */;
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
INSERT INTO `thesismanagement_statusthesis` VALUES (1,'2023-12-09','2023-12-09',1,'Open'),(2,'2023-12-09','2023-12-09',1,'Close');
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
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_the_status_id_061b7942_fk_ThesisMan` (`status_id`),
  KEY `ThesisManagement_the_committee_id_9cdfd684_fk_ThesisMan` (`committee_id`),
  CONSTRAINT `ThesisManagement_the_committee_id_9cdfd684_fk_ThesisMan` FOREIGN KEY (`committee_id`) REFERENCES `thesismanagement_thesisdefensecommittee` (`id`),
  CONSTRAINT `ThesisManagement_the_status_id_061b7942_fk_ThesisMan` FOREIGN KEY (`status_id`) REFERENCES `thesismanagement_statusthesis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesis`
--

LOCK TABLES `thesismanagement_thesis` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesis` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesis` VALUES (1,'2023-12-08','2023-12-17',1,'test update date',1,NULL),(2,'2023-12-08','2023-12-22',1,'Khóa Luận 2',1,1),(3,'2023-12-08','2023-12-08',1,'Khóa Luận 2',1,NULL),(4,'2023-12-08','2023-12-08',1,'Khóa Luận PATCH TEST 2',1,NULL),(5,'2023-12-08','2023-12-08',1,'Khóa Luận 1',1,NULL),(8,'2023-12-08','2023-12-08',1,'Khóa Luận PATCH TEST 2',1,NULL),(9,'2023-12-08','2023-12-08',1,'khoa luan',1,NULL),(10,'2023-12-08','2023-12-08',1,'string',1,NULL),(11,'2023-12-08','2023-12-14',1,'string',1,NULL),(12,'2023-12-12','2023-12-12',1,'Khóa Luận PATCH TEST 2',1,NULL),(13,'2023-12-19','2023-12-19',1,'Khóa Luận PATCH TEST 2',1,NULL),(14,'2023-12-22','2023-12-22',1,'Khóa Luận 1',1,NULL),(15,'2023-12-22','2023-12-22',1,'Khóa Luận 1',1,NULL),(16,'2023-12-22','2023-12-22',1,'Khóa Luận 1',1,NULL),(17,'2023-12-22','2023-12-22',1,'Khóa Luận 1',1,1),(18,'2023-12-22','2023-12-22',1,NULL,1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesisdefensecommittee`
--

LOCK TABLES `thesismanagement_thesisdefensecommittee` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesisdefensecommittee` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesisdefensecommittee` VALUES (1,'2023-12-05','2023-12-17',1,'test update date'),(2,'2023-12-05','2023-12-05',1,'committee 2'),(3,'2023-12-08','2023-12-08',1,'committee 3');
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
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_the_thesis_id_7b930d3f_fk_ThesisMan` (`thesis_id`),
  KEY `ThesisManagement_the_user_id_fff2900d_fk_ThesisMan` (`user_id`),
  CONSTRAINT `ThesisManagement_the_thesis_id_7b930d3f_fk_ThesisMan` FOREIGN KEY (`thesis_id`) REFERENCES `thesismanagement_thesis` (`id`),
  CONSTRAINT `ThesisManagement_the_user_id_fff2900d_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesisstudent`
--

LOCK TABLES `thesismanagement_thesisstudent` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesisstudent` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesisstudent` VALUES (10,'2023-12-08','2023-12-08',1,8,1),(11,'2023-12-08','2023-12-08',1,8,2),(12,'2023-12-08','2023-12-08',1,8,3),(13,'2023-12-08','2023-12-08',1,9,1),(14,'2023-12-08','2023-12-08',1,9,3),(15,'2023-12-08','2023-12-08',1,10,1),(16,'2023-12-08','2023-12-08',1,10,2),(17,'2023-12-08','2023-12-08',1,11,1),(18,'2023-12-08','2023-12-08',1,11,2),(19,'2023-12-12','2023-12-12',1,12,3),(20,'2023-12-12','2023-12-12',1,1,4),(21,'2023-12-12','2023-12-12',1,2,4),(22,'2023-12-12','2023-12-12',1,3,4),(23,'2023-12-12','2023-12-12',1,4,4),(24,'2023-12-12','2023-12-12',1,5,4),(25,'2023-12-19','2023-12-19',1,13,3),(26,'2023-12-22','2023-12-22',1,14,1),(27,'2023-12-22','2023-12-22',1,14,2),(28,'2023-12-22','2023-12-22',1,14,3),(29,'2023-12-22','2023-12-22',1,15,1),(30,'2023-12-22','2023-12-22',1,15,2),(31,'2023-12-22','2023-12-22',1,15,3),(32,'2023-12-22','2023-12-22',1,16,1),(33,'2023-12-22','2023-12-22',1,16,2),(34,'2023-12-22','2023-12-22',1,16,3),(35,'2023-12-22','2023-12-22',1,17,1),(36,'2023-12-22','2023-12-22',1,17,2),(37,'2023-12-22','2023-12-22',1,17,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesissupervisor`
--

LOCK TABLES `thesismanagement_thesissupervisor` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesissupervisor` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesissupervisor` VALUES (2,'2023-12-12','2023-12-12',1,12,1),(3,'2023-12-12','2023-12-12',1,12,2),(24,'2023-12-12','2023-12-12',1,1,1),(25,'2023-12-12','2023-12-12',1,2,1),(26,'2023-12-12','2023-12-12',1,3,1),(27,'2023-12-12','2023-12-12',1,4,1),(28,'2023-12-12','2023-12-12',1,5,1),(29,'2023-12-12','2023-12-12',1,8,1),(30,'2023-12-12','2023-12-12',1,9,1),(31,'2023-12-12','2023-12-12',1,10,1),(38,'2023-12-14','2023-12-14',1,11,1),(39,'2023-12-19','2023-12-19',1,13,1),(40,'2023-12-19','2023-12-19',1,13,2),(41,'2023-12-22','2023-12-22',1,14,1),(42,'2023-12-22','2023-12-22',1,14,2),(43,'2023-12-22','2023-12-22',1,15,1),(44,'2023-12-22','2023-12-22',1,15,2),(45,'2023-12-22','2023-12-22',1,16,1),(46,'2023-12-22','2023-12-22',1,16,2),(47,'2023-12-22','2023-12-22',1,17,1),(48,'2023-12-22','2023-12-22',1,17,2);
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
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_user`
--

LOCK TABLES `thesismanagement_user` WRITE;
/*!40000 ALTER TABLE `thesismanagement_user` DISABLE KEYS */;
INSERT INTO `thesismanagement_user` VALUES (1,'pbkdf2_sha256$600000$RKW58ajYIpkJhctpQjIKRZ$2MgiegohZv2oDgJ5vnwV0B2weo7SXPwEiHbJEsvwe4U=','2023-12-22 08:10:32.681303',1,'admin','Nguyễn Hiếu','admin','hieu24313@gmail.com',1,1,'2023-12-05 06:23:59.310237','',NULL,'admin'),(2,'pbkdf2_sha256$600000$dvdmXjLjTiNt7kHO7ottkF$M1woHboaRvymfArcOiosduob4JuVEZAxgLCbtHS93Ow=',NULL,1,'hieu','Nguyễn Minh ','Hiếu','2051050138hieu@ou.edu.vn',1,1,'2023-12-05 06:23:59.781290','',NULL,'admin'),(3,'pbkdf2_sha256$600000$bEzNLYnaJGGqcp1v1b7LHI$UNzOy9bzNJRKWeXEEfbZ6yWjyY0IbmuJD5X8yO1Zfuw=',NULL,1,'nhu','Lê Thị Huỳnh','Như','huynhnhu@gmail.com',1,1,'2023-12-05 06:24:00.265572','',NULL,'admin'),(4,'pbkdf2_sha256$600000$Y6NaFuUVLoc3XqwGaTAp8w$9j6SBEymvcqoBqzfydUjDlfUhR4kqA0fT2TfSQwxUw8=',NULL,0,'hieux','hieu','nguyen','hieux123@gmail.com',0,0,'2023-12-12 00:35:00.987435','users/2023/12/hutao.jpg',NULL,'student'),(5,'pbkdf2_sha256$600000$wppr4BTByIexjAfP07fpPM$+FiJzxVef77YgGztcSViIKO/9QyygK58JoC7HpfqUDU=',NULL,1,'giaovu','Giáo','Vụ','giaovu@123.com',1,1,'2023-12-22 08:10:40.000000','','0123456','universityadministrator');
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

-- Dump completed on 2023-12-22 18:08:04
