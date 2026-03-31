-- ================================================
-- SCRIPT DE REINITIALISATION
-- ================================================

-- Suppression des tables dans l'ordre inverse
-- (à cause des clés étrangères)
DROP TABLE IF EXISTS image CASCADE;
DROP TABLE IF EXISTS article CASCADE;
DROP TABLE IF EXISTS utilisateur_role CASCADE;
DROP TABLE IF EXISTS role CASCADE;
DROP TABLE IF EXISTS categorie CASCADE;
DROP TABLE IF EXISTS utilisateur CASCADE;