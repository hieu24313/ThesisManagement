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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add criteria',7,'add_criteria'),(26,'Can change criteria',7,'change_criteria'),(27,'Can delete criteria',7,'delete_criteria'),(28,'Can view criteria',7,'view_criteria'),(29,'Can add member of thesis defense committee',8,'add_memberofthesisdefensecommittee'),(30,'Can change member of thesis defense committee',8,'change_memberofthesisdefensecommittee'),(31,'Can delete member of thesis defense committee',8,'delete_memberofthesisdefensecommittee'),(32,'Can view member of thesis defense committee',8,'view_memberofthesisdefensecommittee'),(33,'Can add position',9,'add_position'),(34,'Can change position',9,'change_position'),(35,'Can delete position',9,'delete_position'),(36,'Can view position',9,'view_position'),(37,'Can add status thesis',10,'add_statusthesis'),(38,'Can change status thesis',10,'change_statusthesis'),(39,'Can delete status thesis',10,'delete_statusthesis'),(40,'Can view status thesis',10,'view_statusthesis'),(41,'Can add thesis',11,'add_thesis'),(42,'Can change thesis',11,'change_thesis'),(43,'Can delete thesis',11,'delete_thesis'),(44,'Can view thesis',11,'view_thesis'),(45,'Can add thesis defense committee',12,'add_thesisdefensecommittee'),(46,'Can change thesis defense committee',12,'change_thesisdefensecommittee'),(47,'Can delete thesis defense committee',12,'delete_thesisdefensecommittee'),(48,'Can view thesis defense committee',12,'view_thesisdefensecommittee'),(49,'Can add thesis supervisor',13,'add_thesissupervisor'),(50,'Can change thesis supervisor',13,'change_thesissupervisor'),(51,'Can delete thesis supervisor',13,'delete_thesissupervisor'),(52,'Can view thesis supervisor',13,'view_thesissupervisor'),(53,'Can add thesis student',14,'add_thesisstudent'),(54,'Can change thesis student',14,'change_thesisstudent'),(55,'Can delete thesis student',14,'delete_thesisstudent'),(56,'Can view thesis student',14,'view_thesisstudent'),(57,'Can add thesis examination committee',15,'add_thesisexaminationcommittee'),(58,'Can change thesis examination committee',15,'change_thesisexaminationcommittee'),(59,'Can delete thesis examination committee',15,'delete_thesisexaminationcommittee'),(60,'Can view thesis examination committee',15,'view_thesisexaminationcommittee'),(61,'Can add score',16,'add_score'),(62,'Can change score',16,'change_score'),(63,'Can delete score',16,'delete_score'),(64,'Can view score',16,'view_score'),(65,'Can add role',17,'add_role'),(66,'Can change role',17,'change_role'),(67,'Can delete role',17,'delete_role'),(68,'Can view role',17,'view_role'),(69,'Can add majors',18,'add_majors'),(70,'Can change majors',18,'change_majors'),(71,'Can delete majors',18,'delete_majors'),(72,'Can view majors',18,'view_majors'),(73,'Can add room',19,'add_room'),(74,'Can change room',19,'change_room'),(75,'Can delete room',19,'delete_room'),(76,'Can view room',19,'view_room'),(77,'Can add message',20,'add_message'),(78,'Can change message',20,'change_message'),(79,'Can delete message',20,'delete_message'),(80,'Can view message',20,'view_message'),(81,'Can add application',21,'add_application'),(82,'Can change application',21,'change_application'),(83,'Can delete application',21,'delete_application'),(84,'Can view application',21,'view_application'),(85,'Can add access token',22,'add_accesstoken'),(86,'Can change access token',22,'change_accesstoken'),(87,'Can delete access token',22,'delete_accesstoken'),(88,'Can view access token',22,'view_accesstoken'),(89,'Can add grant',23,'add_grant'),(90,'Can change grant',23,'change_grant'),(91,'Can delete grant',23,'delete_grant'),(92,'Can view grant',23,'view_grant'),(93,'Can add refresh token',24,'add_refreshtoken'),(94,'Can change refresh token',24,'change_refreshtoken'),(95,'Can delete refresh token',24,'delete_refreshtoken'),(96,'Can view refresh token',24,'view_refreshtoken'),(97,'Can add id token',25,'add_idtoken'),(98,'Can change id token',25,'change_idtoken'),(99,'Can delete id token',25,'delete_idtoken'),(100,'Can view id token',25,'view_idtoken');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(22,'oauth2_provider','accesstoken'),(21,'oauth2_provider','application'),(23,'oauth2_provider','grant'),(25,'oauth2_provider','idtoken'),(24,'oauth2_provider','refreshtoken'),(5,'sessions','session'),(7,'ThesisManagement','criteria'),(18,'ThesisManagement','majors'),(8,'ThesisManagement','memberofthesisdefensecommittee'),(20,'ThesisManagement','message'),(9,'ThesisManagement','position'),(17,'ThesisManagement','role'),(19,'ThesisManagement','room'),(16,'ThesisManagement','score'),(10,'ThesisManagement','statusthesis'),(11,'ThesisManagement','thesis'),(12,'ThesisManagement','thesisdefensecommittee'),(15,'ThesisManagement','thesisexaminationcommittee'),(14,'ThesisManagement','thesisstudent'),(13,'ThesisManagement','thesissupervisor'),(6,'ThesisManagement','user');
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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-02-27 16:34:15.106549'),(2,'contenttypes','0002_remove_content_type_name','2024-02-27 16:34:15.273491'),(3,'auth','0001_initial','2024-02-27 16:34:17.073768'),(4,'auth','0002_alter_permission_name_max_length','2024-02-27 16:34:17.205581'),(5,'auth','0003_alter_user_email_max_length','2024-02-27 16:34:17.244521'),(6,'auth','0004_alter_user_username_opts','2024-02-27 16:34:17.252218'),(7,'auth','0005_alter_user_last_login_null','2024-02-27 16:34:17.260415'),(8,'auth','0006_require_contenttypes_0002','2024-02-27 16:34:17.264746'),(9,'auth','0007_alter_validators_add_error_messages','2024-02-27 16:34:17.303705'),(10,'auth','0008_alter_user_username_max_length','2024-02-27 16:34:17.312318'),(11,'auth','0009_alter_user_last_name_max_length','2024-02-27 16:34:17.321215'),(12,'auth','0010_alter_group_name_max_length','2024-02-27 16:34:17.366692'),(13,'auth','0011_update_proxy_permissions','2024-02-27 16:34:17.377079'),(14,'auth','0012_alter_user_first_name_max_length','2024-02-27 16:34:17.388808'),(15,'ThesisManagement','0001_initial','2024-02-27 16:34:19.979141'),(16,'ThesisManagement','0002_user_avatar_user_phone_alter_criteria_name_and_more','2024-02-27 16:34:20.204560'),(17,'ThesisManagement','0003_delete_criteria_and_more','2024-02-27 16:34:21.106675'),(18,'ThesisManagement','0004_alter_user_groups_alter_user_user_permissions','2024-02-27 16:34:21.137509'),(19,'ThesisManagement','0005_criteria_memberofthesisdefensecommittee_position_and_more','2024-02-27 16:34:22.278915'),(20,'ThesisManagement','0006_alter_user_groups_alter_user_user_permissions','2024-02-27 16:34:22.311572'),(21,'ThesisManagement','0007_score_thesis','2024-02-27 16:34:22.394308'),(22,'ThesisManagement','0008_alter_user_avatar_alter_user_phone','2024-02-27 16:34:22.424788'),(23,'ThesisManagement','0009_user_role','2024-02-27 16:34:22.504932'),(24,'ThesisManagement','0010_role_alter_user_role','2024-02-27 16:34:22.865387'),(25,'ThesisManagement','0011_alter_user_role','2024-02-27 16:34:23.074683'),(26,'ThesisManagement','0012_alter_user_role','2024-02-27 16:34:23.164383'),(27,'ThesisManagement','0013_alter_user_role','2024-02-27 16:34:23.179336'),(28,'ThesisManagement','0014_alter_user_role','2024-02-27 16:34:23.193495'),(29,'ThesisManagement','0015_remove_thesisexaminationcommittee_committee_and_more','2024-02-27 16:34:23.469116'),(30,'ThesisManagement','0016_thesis_status','2024-02-27 16:34:23.569219'),(31,'ThesisManagement','0017_remove_thesisdefensecommittee_thesis_and_more','2024-02-27 16:34:23.794571'),(32,'ThesisManagement','0018_remove_thesis_committee_thesis_committee','2024-02-27 16:34:24.057080'),(33,'ThesisManagement','0019_alter_user_avatar','2024-02-27 16:34:24.441338'),(34,'ThesisManagement','0020_rename_memberofcommittee_score_lecturer_and_more','2024-02-27 16:34:24.785745'),(35,'ThesisManagement','0021_score_criteria','2024-02-27 16:34:24.901292'),(36,'ThesisManagement','0022_alter_score_lecturer_alter_score_student','2024-02-27 16:34:25.323967'),(37,'ThesisManagement','0023_alter_score_score','2024-02-27 16:34:25.405164'),(38,'ThesisManagement','0024_majors_alter_user_role_thesis_major_user_major','2024-02-27 16:34:25.694922'),(39,'ThesisManagement','0025_user_temp_password','2024-02-27 16:34:25.756942'),(40,'ThesisManagement','0026_thesisstudent_total_alter_score_score','2024-02-27 16:34:25.879571'),(41,'ThesisManagement','0027_alter_user_avatar','2024-02-27 16:34:26.002265'),(42,'ThesisManagement','0028_thesissupervisor_type_user_address_and_more','2024-02-27 16:34:26.181253'),(43,'ThesisManagement','0029_alter_user_date_of_birth','2024-02-27 16:34:26.277502'),(44,'ThesisManagement','0030_room_message','2024-02-27 16:34:26.706019'),(45,'ThesisManagement','0031_remove_thesis_status_thesisdefensecommittee_status','2024-02-27 16:34:26.915451'),(46,'ThesisManagement','0032_alter_room_name','2024-02-27 16:34:26.958970'),(47,'ThesisManagement','0033_alter_room_name','2024-02-27 16:34:26.993763'),(48,'ThesisManagement','0034_remove_message_room_message_active_and_more','2024-02-27 16:34:27.573023'),(49,'ThesisManagement','0035_remove_message_created_at','2024-02-27 16:34:27.611075'),(50,'ThesisManagement','0036_message_created_at','2024-02-27 16:34:27.656603'),(51,'admin','0001_initial','2024-02-27 16:34:27.840558'),(52,'admin','0002_logentry_remove_auto_add','2024-02-27 16:34:27.861823'),(53,'admin','0003_logentry_add_action_flag_choices','2024-02-27 16:34:27.885823'),(54,'oauth2_provider','0001_initial','2024-02-27 16:34:28.789815'),(55,'oauth2_provider','0002_auto_20190406_1805','2024-02-27 16:34:28.867000'),(56,'oauth2_provider','0003_auto_20201211_1314','2024-02-27 16:34:28.944510'),(57,'oauth2_provider','0004_auto_20200902_2022','2024-02-27 16:34:29.630851'),(58,'oauth2_provider','0005_auto_20211222_2352','2024-02-27 16:34:29.810115'),(59,'oauth2_provider','0006_alter_application_client_secret','2024-02-27 16:34:29.869053'),(60,'oauth2_provider','0007_application_post_logout_redirect_uris','2024-02-27 16:34:29.993279'),(61,'sessions','0001_initial','2024-02-27 16:34:30.039893');
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
INSERT INTO `django_session` VALUES ('k1teovise3kmx9btqbri1f4lu7l0i4ws','.eJxVjMsOwiAQRf-FtSEztDx06d5vIAMDUjWQlHZl_HdD0oVu7znnvoWnfSt-72n1C4uLQHH63QLFZ6oD8IPqvcnY6rYuQQ5FHrTLW-P0uh7u30GhXkYNaUbMjJmAdXSoI2nMAJOJbJXOswlk8GyCtdqAY54MwaRAuagggfh8AeMCN00:1rf0XC:F8OwVPlO9u5SxaATa8xXOpbQ9Rz-6tJCbfhPqwZAAkc','2024-03-12 16:42:26.101169');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'wjIByltjGFrANozVDR4evHsC40LFkW','2024-02-28 02:47:15.743613','read write',1,1,'2024-02-27 16:47:15.747122','2024-02-27 16:47:15.747122',NULL,NULL),(2,'QbZ1FxvyNPKRHn1HLm9kLJAxGRn8sO','2024-02-28 02:51:47.335883','read write',1,1,'2024-02-27 16:51:47.336847','2024-02-27 16:51:47.336847',NULL,NULL),(3,'CqYkeJ74iLgjkWgCE9aWQR8MixeBmG','2024-02-28 02:56:35.482003','read write',1,1,'2024-02-27 16:56:35.482003','2024-02-27 16:56:35.482003',NULL,NULL),(4,'JYMCzOSqLFqPh7THEXXzZP7lT9BkoH','2024-02-28 03:00:48.045632','read write',1,1,'2024-02-27 17:00:48.045632','2024-02-27 17:00:48.045632',NULL,NULL),(5,'eGAIXqy2s7w0Jz3oWkXovX0Wqot3ac','2024-02-28 03:17:22.555147','read write',1,32,'2024-02-27 17:17:22.555147','2024-02-27 17:17:22.555147',NULL,NULL),(6,'zjFaXFFgu48JMz75eGhQXQqk0btT1y','2024-02-28 03:18:18.111986','read write',1,33,'2024-02-27 17:18:18.127577','2024-02-27 17:18:18.127577',NULL,NULL),(7,'zVNg6e4p42N76gcgrZ9YMgxUBrIFc0','2024-02-28 03:18:33.260932','read write',1,33,'2024-02-27 17:18:33.260932','2024-02-27 17:18:33.260932',NULL,NULL),(8,'qI6XEAGkiVQunYPupZMPBJkpfJ8RNQ','2024-02-28 03:21:38.519313','read write',1,34,'2024-02-27 17:21:38.519313','2024-02-27 17:21:38.519313',NULL,NULL),(9,'KNJq1ykSC50QK4rku4TNh9Il0z9dqu','2024-02-28 03:23:45.715779','read write',1,34,'2024-02-27 17:23:45.715779','2024-02-27 17:23:45.715779',NULL,NULL),(10,'3Y7YH943mKMajTr7vmNCFLG9M17L11','2024-02-28 03:24:51.106590','read write',1,35,'2024-02-27 17:24:51.106590','2024-02-27 17:24:51.106590',NULL,NULL),(11,'eXkiIpNPPmrddiFFpUtLlkIlxRTFXp','2024-02-28 03:25:15.486893','read write',1,36,'2024-02-27 17:25:15.486893','2024-02-27 17:25:15.486893',NULL,NULL),(12,'XD89gY8ldHZjo4wNUYzMBDcrxDMNuq','2024-02-28 03:25:47.379745','read write',1,1,'2024-02-27 17:25:47.379745','2024-02-27 17:25:47.379745',NULL,NULL),(13,'hCT9GZHYgU4Xpc7JoaDLGUIK8Aqqu6','2024-02-28 03:26:27.718274','read write',1,1,'2024-02-27 17:26:27.718274','2024-02-27 17:26:27.718274',NULL,NULL);
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
INSERT INTO `oauth2_provider_application` VALUES (1,'ruse9DiDD2p74fejZ2T5Ffkibhiq7n2Zl99thins','','confidential','password','pbkdf2_sha256$600000$WBP6W6bdySZEcnMqZvCeAT$ZrkxF5Hsng2IPJ/e7uUB/ZhLBdaR3lHzxjbrCnA1iQI=','Thesis Management',1,0,'2024-02-27 16:43:09.185277','2024-02-27 16:43:09.185277','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'ysEdLGE9bIpyWu81CcS4IKtlMkel0c',1,1,1,'2024-02-27 16:47:15.791182','2024-02-27 16:47:15.791182',NULL),(2,'UNXTYOxyupCuPiZu1s1QueuQDn4Jcg',2,1,1,'2024-02-27 16:51:47.339521','2024-02-27 16:51:47.339521',NULL),(3,'MepfdVYT3qx4NGgkdOLfwauKD08Pik',3,1,1,'2024-02-27 16:56:35.485991','2024-02-27 16:56:35.485991',NULL),(4,'ZYNLjzRza99Vr2kE46a4NekExitLSL',4,1,1,'2024-02-27 17:00:48.049439','2024-02-27 17:00:48.049439',NULL),(5,'365emQvVAZCKD0C7cnRzyqor2wrgTp',5,1,32,'2024-02-27 17:17:22.555147','2024-02-27 17:17:22.555147',NULL),(6,'aprtbWshO5WvOmIM5t7ClLu15bR2mo',6,1,33,'2024-02-27 17:18:18.128651','2024-02-27 17:18:18.128651',NULL),(7,'JE4pTVuic4CEgRAWaRt0Pp2K2e9svX',7,1,33,'2024-02-27 17:18:33.260932','2024-02-27 17:18:33.260932',NULL),(8,'LoG5eZX6UX57GaVBRXLsViD9dMFBjC',8,1,34,'2024-02-27 17:21:38.519313','2024-02-27 17:21:38.519313',NULL),(9,'EiK1hWp6H9sI1gYa8GZh01sUo6UUiw',9,1,34,'2024-02-27 17:23:45.719566','2024-02-27 17:23:45.719680',NULL),(10,'WfRqIFHWw40DQU1wun5BSeKIZN5AzW',10,1,35,'2024-02-27 17:24:51.106590','2024-02-27 17:24:51.106590',NULL),(11,'Gy83CF4np4fR9MtDjLITEesjkxXi4e',11,1,36,'2024-02-27 17:25:15.486893','2024-02-27 17:25:15.486893',NULL),(12,'xQ3kxMvygWgCh9vVTYEtBnWgeUwBBA',12,1,1,'2024-02-27 17:25:47.379745','2024-02-27 17:25:47.379745',NULL),(13,'NJLPd3ZIhTOi0e6VaWV8bSel3ZjsVW',13,1,1,'2024-02-27 17:26:27.719574','2024-02-27 17:26:27.719574',NULL);
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
INSERT INTO `thesismanagement_criteria` VALUES (1,'2024-02-27','2024-02-27',1,'Điểm Trình Bày',20),(2,'2024-02-27','2024-02-27',1,'Điểm Phản Biện',30),(3,'2024-02-27','2024-02-27',1,'Điểm Sản Phẩm',50);
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
INSERT INTO `thesismanagement_majors` VALUES (1,'2024-02-27','2024-02-27',1,'Công Nghệ Thông Tin'),(2,'2024-02-27','2024-02-27',1,'Khoa Học Máy Tính'),(3,'2024-02-27','2024-02-27',1,'Tài Chính Ngân Hàng'),(4,'2024-02-27','2024-02-27',1,'Trí Tuệ Nhân Tạo');
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_memberofthesisdefensecommittee`
--

LOCK TABLES `thesismanagement_memberofthesisdefensecommittee` WRITE;
/*!40000 ALTER TABLE `thesismanagement_memberofthesisdefensecommittee` DISABLE KEYS */;
INSERT INTO `thesismanagement_memberofthesisdefensecommittee` VALUES (1,'2024-02-28','2024-02-28',1,1,1,32),(2,'2024-02-28','2024-02-28',1,1,2,33),(3,'2024-02-28','2024-02-28',1,1,3,34),(4,'2024-02-28','2024-02-28',1,1,4,35),(5,'2024-02-28','2024-02-28',1,1,5,36),(6,'2024-02-28','2024-02-28',1,2,1,45),(7,'2024-02-28','2024-02-28',1,2,2,44),(8,'2024-02-28','2024-02-28',1,2,3,43),(9,'2024-02-28','2024-02-28',1,2,4,41),(10,'2024-02-28','2024-02-28',1,2,5,33),(11,'2024-02-28','2024-02-28',1,3,1,34),(12,'2024-02-28','2024-02-28',1,3,2,32),(13,'2024-02-28','2024-02-28',1,3,3,33),(14,'2024-02-28','2024-02-28',1,3,4,38),(15,'2024-02-28','2024-02-28',1,3,5,35),(16,'2024-02-28','2024-02-28',1,4,1,44),(17,'2024-02-28','2024-02-28',1,4,2,33),(18,'2024-02-28','2024-02-28',1,4,3,32),(19,'2024-02-28','2024-02-28',1,4,4,40),(20,'2024-02-28','2024-02-28',1,5,1,36),(21,'2024-02-28','2024-02-28',1,5,2,33),(22,'2024-02-28','2024-02-28',1,5,3,35),(23,'2024-02-28','2024-02-28',1,5,4,32);
/*!40000 ALTER TABLE `thesismanagement_memberofthesisdefensecommittee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_message`
--

DROP TABLE IF EXISTS `thesismanagement_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` longtext COLLATE utf8mb4_unicode_ci,
  `user_id` bigint DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `user_receive_id` bigint DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_mes_user_receive_id_66c80518_fk_ThesisMan` (`user_receive_id`),
  KEY `ThesisManagement_mes_user_id_cc72db0b_fk_ThesisMan` (`user_id`),
  CONSTRAINT `ThesisManagement_mes_user_id_cc72db0b_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`),
  CONSTRAINT `ThesisManagement_mes_user_receive_id_66c80518_fk_ThesisMan` FOREIGN KEY (`user_receive_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_message`
--

LOCK TABLES `thesismanagement_message` WRITE;
/*!40000 ALTER TABLE `thesismanagement_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `thesismanagement_message` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_position`
--

LOCK TABLES `thesismanagement_position` WRITE;
/*!40000 ALTER TABLE `thesismanagement_position` DISABLE KEYS */;
INSERT INTO `thesismanagement_position` VALUES (1,'2024-02-27','2024-02-27',1,'Chủ Tịch'),(2,'2024-02-27','2024-02-27',1,'Thư Ký'),(3,'2024-02-27','2024-02-27',1,'Phản Biện'),(4,'2024-02-27','2024-02-27',1,'Thành Viên 1'),(5,'2024-02-27','2024-02-27',1,'Thành Viên 2');
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
INSERT INTO `thesismanagement_role` VALUES (1,'2024-02-27','2024-02-27',1,'admin'),(2,'2024-02-27','2024-02-27',1,'universityadministrator'),(3,'2024-02-27','2024-02-27',1,'lecturer'),(4,'2024-02-27','2024-02-27',1,'student');
/*!40000 ALTER TABLE `thesismanagement_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_room`
--

DROP TABLE IF EXISTS `thesismanagement_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ThesisManagement_room_name_f6bf987c_uniq` (`name`),
  KEY `ThesisManagement_roo_host_id_0bc05bee_fk_ThesisMan` (`host_id`),
  CONSTRAINT `ThesisManagement_roo_host_id_0bc05bee_fk_ThesisMan` FOREIGN KEY (`host_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_room`
--

LOCK TABLES `thesismanagement_room` WRITE;
/*!40000 ALTER TABLE `thesismanagement_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `thesismanagement_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thesismanagement_room_current_users`
--

DROP TABLE IF EXISTS `thesismanagement_room_current_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thesismanagement_room_current_users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ThesisManagement_room_cu_room_id_user_id_f034209a_uniq` (`room_id`,`user_id`),
  KEY `ThesisManagement_roo_user_id_a9e7779f_fk_ThesisMan` (`user_id`),
  CONSTRAINT `ThesisManagement_roo_room_id_db340bf3_fk_ThesisMan` FOREIGN KEY (`room_id`) REFERENCES `thesismanagement_room` (`id`),
  CONSTRAINT `ThesisManagement_roo_user_id_a9e7779f_fk_ThesisMan` FOREIGN KEY (`user_id`) REFERENCES `thesismanagement_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_room_current_users`
--

LOCK TABLES `thesismanagement_room_current_users` WRITE;
/*!40000 ALTER TABLE `thesismanagement_room_current_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `thesismanagement_room_current_users` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_score`
--

LOCK TABLES `thesismanagement_score` WRITE;
/*!40000 ALTER TABLE `thesismanagement_score` DISABLE KEYS */;
INSERT INTO `thesismanagement_score` VALUES (1,'2024-02-28','2024-02-28',1,6,1,1,1,1),(2,'2024-02-28','2024-02-28',1,6,1,2,1,1),(3,'2024-02-28','2024-02-28',1,8,1,1,1,2),(4,'2024-02-28','2024-02-28',1,8,1,2,1,2),(5,'2024-02-28','2024-02-28',1,9,1,1,1,3),(6,'2024-02-28','2024-02-28',1,9,1,2,1,3),(7,'2024-02-28','2024-02-28',1,7,2,1,1,1),(8,'2024-02-28','2024-02-28',1,7,2,2,1,1),(9,'2024-02-28','2024-02-28',1,8,2,1,1,2),(10,'2024-02-28','2024-02-28',1,9,2,1,1,3),(11,'2024-02-28','2024-02-28',1,8,2,2,1,2),(12,'2024-02-28','2024-02-28',1,9,2,2,1,3),(13,'2024-02-28','2024-02-28',1,8,3,1,1,1),(14,'2024-02-28','2024-02-28',1,8,3,1,1,2),(15,'2024-02-28','2024-02-28',1,8,3,1,1,3),(16,'2024-02-28','2024-02-28',1,8,3,2,1,1),(17,'2024-02-28','2024-02-28',1,8,3,2,1,2),(18,'2024-02-28','2024-02-28',1,8,3,2,1,3),(19,'2024-02-28','2024-02-28',1,7,4,1,1,1),(20,'2024-02-28','2024-02-28',1,7,4,1,1,2),(21,'2024-02-28','2024-02-28',1,7,4,2,1,1),(22,'2024-02-28','2024-02-28',1,7,4,2,1,2),(23,'2024-02-28','2024-02-28',1,9,4,2,1,3),(24,'2024-02-28','2024-02-28',1,8,5,1,1,1),(25,'2024-02-28','2024-02-28',1,9,5,1,1,2),(26,'2024-02-28','2024-02-28',1,9,5,1,1,3),(27,'2024-02-28','2024-02-28',1,8,5,2,1,1),(28,'2024-02-28','2024-02-28',1,9,5,2,1,2),(29,'2024-02-28','2024-02-28',1,9,5,2,1,3);
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
INSERT INTO `thesismanagement_statusthesis` VALUES (1,'2024-02-27','2024-02-27',1,'Open'),(2,'2024-02-27','2024-02-27',1,'Close');
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
  `committee_id` bigint DEFAULT NULL,
  `major_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_the_committee_id_9cdfd684_fk_ThesisMan` (`committee_id`),
  KEY `ThesisManagement_the_major_id_c0d533d3_fk_ThesisMan` (`major_id`),
  CONSTRAINT `ThesisManagement_the_committee_id_9cdfd684_fk_ThesisMan` FOREIGN KEY (`committee_id`) REFERENCES `thesismanagement_thesisdefensecommittee` (`id`),
  CONSTRAINT `ThesisManagement_the_major_id_c0d533d3_fk_ThesisMan` FOREIGN KEY (`major_id`) REFERENCES `thesismanagement_majors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesis`
--

LOCK TABLES `thesismanagement_thesis` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesis` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesis` VALUES (1,'2024-02-28','2024-02-28',1,'Nghiên cứu về trí tuệ nhân tạo',1,1),(2,'2024-02-28','2024-02-28',1,'Môi trường và con người',2,2),(3,'2024-02-28','2024-02-28',1,'Phát triển hệ thống quản lý khoá luận',3,1);
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
  `status_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ThesisManagement_the_status_id_448f2181_fk_ThesisMan` (`status_id`),
  CONSTRAINT `ThesisManagement_the_status_id_448f2181_fk_ThesisMan` FOREIGN KEY (`status_id`) REFERENCES `thesismanagement_statusthesis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesisdefensecommittee`
--

LOCK TABLES `thesismanagement_thesisdefensecommittee` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesisdefensecommittee` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesisdefensecommittee` VALUES (1,'2024-02-28','2024-02-28',0,'Hồi đồng 1',1),(2,'2024-02-28','2024-02-28',0,'Hội đồng 2',1),(3,'2024-02-28','2024-02-28',0,'Hội đồng 3',1),(4,'2024-02-28','2024-02-28',0,'Hội đồng 4',1),(5,'2024-02-28','2024-02-28',0,'Hội đồng 5',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thesismanagement_thesisstudent`
--

LOCK TABLES `thesismanagement_thesisstudent` WRITE;
/*!40000 ALTER TABLE `thesismanagement_thesisstudent` DISABLE KEYS */;
INSERT INTO `thesismanagement_thesisstudent` VALUES (1,'2024-02-28','2024-02-28',1,1,4,NULL),(2,'2024-02-28','2024-02-28',1,1,5,NULL),(3,'2024-02-28','2024-02-28',1,2,7,NULL),(4,'2024-02-28','2024-02-28',1,2,6,NULL),(5,'2024-02-28','2024-02-28',1,3,15,NULL),(6,'2024-02-28','2024-02-28',1,3,14,NULL),(7,'2024-02-28','2024-02-28',1,3,13,NULL);
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
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `thesismanagement_thesissupervisor` VALUES (1,'2024-02-28','2024-02-28',1,1,32,'gv1'),(2,'2024-02-28','2024-02-28',1,1,33,'gv1'),(3,'2024-02-28','2024-02-28',1,2,32,'gv1'),(4,'2024-02-28','2024-02-28',1,2,34,'gv1'),(5,'2024-02-28','2024-02-28',1,3,36,'gv1'),(6,'2024-02-28','2024-02-28',1,3,37,'gv1');
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
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `thesismanagement_user` VALUES (1,'pbkdf2_sha256$600000$8Ay3Ybj2Q10sYbBpAuzkLz$qNFpkHj6qERJn0rKvdkBG9F8XdNc4eBxZCfJv8CMKzU=','2024-02-27 16:42:26.094093',1,'admin','admin','admin','hieu24313@gmail.com',1,1,'2024-02-27 16:34:30.387671',NULL,NULL,'admin',1,NULL,NULL,NULL,NULL),(2,'pbkdf2_sha256$600000$WO7Ir0S8hHCSV4ujPxuDHy$OHPvIq8Nim3BSrMOfBQuvDeVBCFRXGUCeXBzyz+difo=',NULL,1,'hieu','Hiếu','Nguyễn Minh','2051050138hieu@ou.edu.vn',1,1,'2024-02-27 16:34:31.100537',NULL,NULL,'admin',NULL,NULL,NULL,NULL,NULL),(3,'pbkdf2_sha256$600000$2s2TLCfJbZPmOC99RC2lxk$UrGCM9DNW7LgDabci3p/sevulipi8X2BubMfLXYL0Mw=',NULL,1,'nhu','Như','Lê Thị Huỳnh','2051050327nhu@ou.edu.vn',1,1,'2024-02-27 16:34:33.383654',NULL,NULL,'admin',NULL,NULL,NULL,NULL,NULL),(4,'pbkdf2_sha256$600000$qBPU7EjIcgtk6EpyKZTflT$It9tsplGy8yPRR2F2hkTJkAvOked7liyPjyTDEeeAns=',NULL,0,'sinhvien1','An','Vũ','hieu24313@gmail.com',0,1,'2024-02-27 16:34:34.791130',NULL,NULL,'student',1,NULL,NULL,NULL,NULL),(5,'pbkdf2_sha256$600000$GzUVWYaAYcrzq4GoRWOV4g$EPMP/uQPcBQ1P53BRou1kEoLpSeSmsuzvP1GGfl8Ggc=',NULL,0,'sinhvien2','Phong','Duy','hieu24313@gmail.com',0,1,'2024-02-27 16:34:36.143895',NULL,NULL,'student',1,NULL,NULL,NULL,NULL),(6,'pbkdf2_sha256$600000$Qv9lDj8ea9hw5ow1KFJkFi$SH1PjEWwiyVY9O+VTRY2Y9EFyztxDomsajuKXhIO2zA=',NULL,0,'sinhvien3','Tùng','Lý','hieu24313@gmail.com',0,1,'2024-02-27 16:34:36.865778',NULL,NULL,'student',1,NULL,NULL,NULL,NULL),(7,'pbkdf2_sha256$600000$TZ86kMBICsboNdFjQrm3Vd$Ga0HDTHj43hkxzCsTJJw1G6XZQ31BV8F4d7dqc3RfnA=',NULL,0,'sinhvien4','Thi','Võ','hieu24313@gmail.com',0,1,'2024-02-27 16:34:37.551854',NULL,NULL,'student',2,NULL,NULL,NULL,NULL),(8,'pbkdf2_sha256$600000$egv9hk7sSrKh2lKA1jswPu$Abn+PUsHNVmtOFxuTJN+mkxHGMAazkUgd2dtz0oJcIE=',NULL,0,'sinhvien5','Trung','Võ','hieu24313@gmail.com',0,1,'2024-02-27 16:34:38.189960',NULL,NULL,'student',2,NULL,NULL,NULL,NULL),(9,'pbkdf2_sha256$600000$FCo3W15pGDiiz6VgJeSHCE$vqigtAvevcBkHrIyGNMsz0bftE6ENCRfFomCoFwZBOY=',NULL,0,'sinhvien6','Minh','Trần','hieu24313@gmail.com',0,1,'2024-02-27 16:34:38.758900',NULL,NULL,'student',3,NULL,NULL,NULL,NULL),(10,'pbkdf2_sha256$600000$DIiqeNihTqGGtx4IFrNo7M$uSh6yfeMw6hybavPiAuW3fZ6FgKUmRSJE7iWI9IK7/k=',NULL,0,'sinhvien7','Hà','Trần','hieu24313@gmail.com',0,1,'2024-02-27 16:34:39.251503',NULL,NULL,'student',3,NULL,NULL,NULL,NULL),(11,'pbkdf2_sha256$600000$kuOvEmeXtTZuqqZntYRnzX$vSeCXtmXm2XNOUjdHRRgf9B1J+VqbsWtd2XVwulp/58=',NULL,0,'sinhvien8','Vân','Lê','hieu24313@gmail.com',0,1,'2024-02-27 16:34:39.741064',NULL,NULL,'student',4,NULL,NULL,NULL,NULL),(12,'pbkdf2_sha256$600000$AgObmjg0o0w7Qkrkm85IQh$7TQq1QwSL0GAxaZrwZGuDCqzuWplEbrjNaWM/g3wNIU=',NULL,0,'sinhvien9','Linh','Nguyên','hieu24313@gmail.com',0,1,'2024-02-27 16:34:40.228893',NULL,NULL,'student',4,NULL,NULL,NULL,NULL),(13,'pbkdf2_sha256$600000$ss1QNUtfuaulH5XS9Bcatm$rZg5pkcSbQeiWY0uX+1A/VlL/OjM16XhB3j49CjqgsE=',NULL,0,'sinhvien10','Ngọc','Trần','hieu24313@gmail.com',0,1,'2024-02-27 16:34:40.730123',NULL,NULL,'student',2,NULL,NULL,NULL,NULL),(14,'pbkdf2_sha256$600000$2pFvE7BkyrCxRI1M3ucI50$bUR/ukgi6lZKqK5Fc9EMcZ53v6uiQrsQKSRMd7UZgl8=',NULL,0,'sinhvien11','Thi','Quách','hieu24313@gmail.com',0,1,'2024-02-27 16:34:41.394871',NULL,NULL,'student',3,NULL,NULL,NULL,NULL),(15,'pbkdf2_sha256$600000$hdX5QNtMV77r9ONlB59Hvj$XyryUWlwbu6xHAYcIIxu0cy3IMR66UkqIWZxk+PAkJ0=',NULL,0,'sinhvien12','Minh','Vũ','hieu24313@gmail.com',0,1,'2024-02-27 16:34:41.944411',NULL,NULL,'student',1,NULL,NULL,NULL,NULL),(16,'pbkdf2_sha256$600000$dXbN5advoDnK296WTVgM1m$OBbiqzK1PHNlxOCUmsiYAnXb8FwAxS5pXDrOnYypEhU=',NULL,0,'sinhvien13','Ngọc','Bùi','hieu24313@gmail.com',0,1,'2024-02-27 16:34:42.462510',NULL,NULL,'student',1,NULL,NULL,NULL,NULL),(17,'pbkdf2_sha256$600000$iFAfuvVdkEOXTrFHTmBdTS$+xCXvUjlDM4gwqkcywhpMFUhxGnD03s6GLeh3Erb4b8=',NULL,0,'sinhvien14','Phong','Duy','hieu24313@gmail.com',0,1,'2024-02-27 16:34:42.989067',NULL,NULL,'student',1,NULL,NULL,NULL,NULL),(18,'pbkdf2_sha256$600000$nnU4nOqZCsv9BYVswDEVkN$J2nWM6HQu6vInd7tGx8qDivwyLT2IhEi5gQrrIKJrrE=',NULL,0,'giaovu1','Tú','Lý','hieu24313@gmail.com',0,1,'2024-02-27 16:34:43.499440',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(19,'pbkdf2_sha256$600000$il2mSEcCbgKzDvIhngPWO5$/tg3t7mcS1DT0mcxvVYMWuA1X8lBkUmpWvkCwjM1QTc=',NULL,0,'giaovu2','Ngọc','Duy','hieu24313@gmail.com',0,1,'2024-02-27 16:34:44.048954',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(20,'pbkdf2_sha256$600000$16FiiniCpSruQ096PTps2w$3ib3MfGCQNCiIhiNpqPaGaM7XaXd2WmXC/jApaF3Zjg=',NULL,0,'giaovu3','Trung','Vũ','hieu24313@gmail.com',0,1,'2024-02-27 16:34:44.590677',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(21,'pbkdf2_sha256$600000$CkXcog4OZr6FvW4Lp9fnso$/K1PUez2y29CClhT+pc1AEiWL2BHt4BM2ZxjjwK8NFw=',NULL,0,'giaovu4','Ngọc','Phan','hieu24313@gmail.com',0,1,'2024-02-27 16:34:45.122073',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(22,'pbkdf2_sha256$600000$vsKoMBaACF7ss11qgWpLdN$rQJpnIulT0m3x+6xswNLoxAvgQBFSOOg0Wc7GDm2kJE=',NULL,0,'giaovu5','Anh','Phạm','hieu24313@gmail.com',0,1,'2024-02-27 16:34:45.872397',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(23,'pbkdf2_sha256$600000$Jlx1PxaBdCLv3AYYYNATWI$8UOhh0+G5wUstpK/9Kpy9l5cDPKorDDWqoYBPQ6Og0M=',NULL,0,'giaovu6','Quang','Nguyên','hieu24313@gmail.com',0,1,'2024-02-27 16:34:47.350644',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(24,'pbkdf2_sha256$600000$KQiS8VOWT6e0uHugjwkSvi$+iXa8plRRdSuiA6MB6WCTEPih1FkkxXiWw3iwBTKnMw=',NULL,0,'giaovu7','Thi','Phạm','hieu24313@gmail.com',0,1,'2024-02-27 16:34:48.560012',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(25,'pbkdf2_sha256$600000$WMsMp4Cc1FkVFNmLnoBLNk$05OZ9zer4yShTt4m3yelIKxHuhECw1C1FkyMbr/goU4=',NULL,0,'giaovu8','Quang','Bùi','hieu24313@gmail.com',0,1,'2024-02-27 16:34:49.368665',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(26,'pbkdf2_sha256$600000$e9sokRD1QidPwZAkmelFgN$VXU5ToEbR75uYU74T6bOsA1nO5BXLN2J341koaRx1P8=',NULL,0,'giaovu9','Thi','Duy','hieu24313@gmail.com',0,1,'2024-02-27 16:34:50.508836',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(27,'pbkdf2_sha256$600000$2i2Mfj8Nv1X4uTGa1KVjTV$IpYslerxXi2+hxbdWuyN2GXp0tz2X5NSA/vWgmx62uk=',NULL,0,'giaovu10','Thi','Mai','hieu24313@gmail.com',0,1,'2024-02-27 16:34:52.849876',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(28,'pbkdf2_sha256$600000$JsGvM1h09uOj0T5KE4fkoD$ZKefShN+GFH/raWg0bwSd/wXkR8HZjm4oI8de9YU3DU=',NULL,0,'giaovu11','Tâm','Phạm','hieu24313@gmail.com',0,1,'2024-02-27 16:34:54.852529',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(29,'pbkdf2_sha256$600000$BboyOPCOSaawjQ7TWGofAp$Lsarhi8TlSCwuLPHgp4XpbMYIn8IPAL8GNBTZI1hGLM=',NULL,0,'giaovu12','Trung','Ngô','hieu24313@gmail.com',0,1,'2024-02-27 16:34:56.056726',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(30,'pbkdf2_sha256$600000$H5QWi3zYqblEbFiVCjfzvW$7agz+c/7Id36pxAJPCAG16Pc70Kql08J9ORwTgPFdY4=',NULL,0,'giaovu13','Trung','Mai','hieu24313@gmail.com',0,1,'2024-02-27 16:34:57.787067',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(31,'pbkdf2_sha256$600000$IhVwC5rbX4rBN91WztVaHU$uhIEpLIcbY581Tu2Qm1XSjmDoDcGT0jnSwL0Akae0yw=',NULL,0,'giaovu14','An','Ngô','hieu24313@gmail.com',0,1,'2024-02-27 16:34:58.947650',NULL,NULL,'universityadministrator',NULL,NULL,NULL,NULL,NULL),(32,'pbkdf2_sha256$600000$3fNUbHJYrDvmBYXOyKGBd4$NfD5iz119dsefFwN3kGTt5cuWlrSwFmFMC24rU+iuPA=',NULL,0,'giangvien1','An','Quách','hieu24313@gmail.com',0,1,'2024-02-27 16:35:00.038004',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(33,'pbkdf2_sha256$600000$AATtl3z04QY0u9oSbz5g39$s++582mn11kU8oQ0twE8FGPbMXBGhMPh/PL8/8JklXo=',NULL,0,'giangvien2','Hải','Nguyên','hieu24313@gmail.com',0,1,'2024-02-27 16:35:01.157547',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(34,'pbkdf2_sha256$600000$pxQ3C56KIyl68uWCYIInLu$bvuprca2bkJ4DuGMML/b/N56s6cbe4Ofwqj6kqJsde8=',NULL,0,'giangvien3','Hà','Lê','hieu24313@gmail.com',0,1,'2024-02-27 16:35:02.098730',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(35,'pbkdf2_sha256$600000$Ri3quTTS548l7XKEDrHLQj$rc4Z3vlrnCq3a0I0mk9qPZRYnFc0pjQYBgtyonPWdcc=',NULL,0,'giangvien4','An','Nguyên','hieu24313@gmail.com',0,1,'2024-02-27 16:35:03.107273',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(36,'pbkdf2_sha256$600000$2gI86fmXkDt9jczqpf5ylK$cM3kDsYH4YU/ky3t8ifzU25YarpeZDM0mJx1Ba5Hnec=',NULL,0,'giangvien5','Thu','Trần','hieu24313@gmail.com',0,1,'2024-02-27 16:35:03.844220',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(37,'pbkdf2_sha256$600000$QmsiYHTo2uV9iAUSHL4iYN$EL5C/0CS9b9krxyrxmNdEpU/TZtoKyMcuMtYkNSNl2k=',NULL,0,'giangvien6','Hải','Lê','hieu24313@gmail.com',0,1,'2024-02-27 16:35:04.636918',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(38,'pbkdf2_sha256$600000$cQBHT4ClAOgg2m4J8sglVY$Tr7+xj2MBRcVkUsM3sLOmOAMQfvJlTSMlv+b97FGX64=',NULL,0,'giangvien7','Hải','Ngô','hieu24313@gmail.com',0,1,'2024-02-27 16:35:05.944615',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(39,'pbkdf2_sha256$600000$jScqMP5jcrAVeNuHbsEOQ8$BPk4396pZoBDdG6vYgEiRDUsF0Fb92ZskXRIe2lzs0w=',NULL,0,'giangvien8','Linh','Bùi','hieu24313@gmail.com',0,1,'2024-02-27 16:35:07.388689',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(40,'pbkdf2_sha256$600000$uofMsmh4to5kVURu7fmM6J$XXqvFI2HwB81ibVYyB3gLDrAvZEZ4x+xMn6XIgcvxw0=',NULL,0,'giangvien9','Minh','Mai','hieu24313@gmail.com',0,1,'2024-02-27 16:35:08.948894',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(41,'pbkdf2_sha256$600000$jwZSdtSzm0MWDC7Zq7VTPR$R44ErgZ+BkCtXrRWT3uOQiSy8Kc9dVa2Z8WnIY0gLjI=',NULL,0,'giangvien10','An','Lý','hieu24313@gmail.com',0,1,'2024-02-27 16:35:10.402324',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(42,'pbkdf2_sha256$600000$JoRwCdGJC6KfEHVEmJLWHu$X7zW1Ui03AFjm8Ow1fHBrfiCEqiMK7n4znNzgcJYW6Q=',NULL,0,'giangvien11','Hanh','Bùi','hieu24313@gmail.com',0,1,'2024-02-27 16:35:12.042453',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(43,'pbkdf2_sha256$600000$lXdAnT1612DK1Ec9zipZUw$r+fAD2F9wxKCnP8hZuxLQoOJLtrCTahEYJEfaleFcbU=',NULL,0,'giangvien12','Hải','Duy','hieu24313@gmail.com',0,1,'2024-02-27 16:35:14.206598',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(44,'pbkdf2_sha256$600000$LYdGb87nTn8Xqn8pVQAbMq$46rLiBoeX7jjciayAIZ5pSuFX4vNtlSfEbGgj4BrMBM=',NULL,0,'giangvien13','Huy','Bùi','hieu24313@gmail.com',0,1,'2024-02-27 16:35:15.788295',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL),(45,'pbkdf2_sha256$600000$dTgXr4keDRyrIvygyhkaHe$wMZSadRmMxgIXbhCqoVNHE5lzX+Rv95zYDS3peK7ua4=',NULL,0,'giangvien14','Hanh','Duy','hieu24313@gmail.com',0,1,'2024-02-27 16:35:17.035791',NULL,NULL,'lecturer',NULL,NULL,NULL,NULL,NULL);
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

-- Dump completed on 2024-02-28  0:28:32
