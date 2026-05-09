-- 1. Catálogo de Planes
CREATE TABLE Plan (
    Id_plan SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DOUBLE PRECISION NOT NULL
);

-- 2. Usuarios
CREATE TABLE Usuario (
    Id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    edad INT NOT NULL,
    genero VARCHAR(20),
    rol VARCHAR(20) DEFAULT 'PACIENTE', -- PACIENTE, PROFESIONAL, ADMIN
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- 3. Profesionales/Terapeutas
CREATE TABLE Profesional (
    Id_profesional SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Especialidad VARCHAR(100),
    Correo VARCHAR(100)
);

-- 4. Suscripciones
CREATE TABLE Suscripcion (
    Id_suscripcion SERIAL PRIMARY KEY,
    Id_usuario INT NOT NULL REFERENCES Usuario(Id_usuario) ON DELETE CASCADE,
    Id_plan INT NOT NULL REFERENCES Plan(Id_plan),
    Fecha_inicio DATE DEFAULT CURRENT_DATE,
    Fecha_fin DATE,
    estado VARCHAR(20) DEFAULT 'ACTIVO'
);

-- 5. Registro Emocional
CREATE TABLE Registro_emocional (
    Id_registro SERIAL PRIMARY KEY,
    Id_usuario INT NOT NULL REFERENCES Usuario(Id_usuario) ON DELETE CASCADE,
    emocion VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    fecha DATE DEFAULT CURRENT_DATE
);

-- 6. Seguimiento de Estrés y Ansiedad
CREATE TABLE Seguimiento (
    Id_seguimiento SERIAL PRIMARY KEY,
    Id_usuario INT NOT NULL REFERENCES Usuario(Id_usuario) ON DELETE CASCADE,
    nivel_estres INT CHECK (nivel_estres BETWEEN 1 AND 10),
    nivel_ansiedad INT CHECK (nivel_ansiedad BETWEEN 1 AND 10),
    fecha DATE DEFAULT CURRENT_DATE
);

-- 7. Sesiones Terapéuticas
CREATE TABLE Sesion (
    Id_sesion SERIAL PRIMARY KEY,
    Id_usuario INT NOT NULL REFERENCES Usuario(Id_usuario) ON DELETE CASCADE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(20) DEFAULT 'PROGRAMADA'
);

-- 8. Chat y Mensajería
CREATE TABLE Mensaje_Chat (
    Id_mensaje SERIAL PRIMARY KEY,
    Id_sesion INT NOT NULL REFERENCES Sesion(Id_sesion) ON DELETE CASCADE,
    emisor VARCHAR(50) NOT NULL, -- 'PACIENTE' o 'SISTEMA'
    contenido TEXT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ia_alerta_crisis BOOLEAN DEFAULT FALSE,
    ia_score_sentimiento DECIMAL(3,2)
);

-- 9. Diario Personal y Notas
CREATE TABLE Diario_Personal (
    Id_nota SERIAL PRIMARY KEY,
    Id_usuario INT NOT NULL REFERENCES Usuario(Id_usuario) ON DELETE CASCADE,
    contenido TEXT NOT NULL,
    puntuacion_animo_ia DECIMAL(3,2),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. Contactos de Crisis
CREATE TABLE Contacto_Crisis (
    Id_contacto SERIAL PRIMARY KEY,
    Id_usuario INT NOT NULL REFERENCES Usuario(Id_usuario) ON DELETE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    parentesco VARCHAR(50)
);

-- 11. Metas de Bienestar
CREATE TABLE Meta_Bienestar (
    Id_meta SERIAL PRIMARY KEY,
    Id_usuario INT NOT NULL REFERENCES Usuario(Id_usuario) ON DELETE CASCADE,
    descripcion VARCHAR(255) NOT NULL,
    esta_completada BOOLEAN DEFAULT FALSE,
    fecha_limite DATE
);

-- 12. Derivaciones a Profesionales
CREATE TABLE Derivacion (
    Id_derivacion SERIAL PRIMARY KEY,
    Id_usuario INT NOT NULL REFERENCES Usuario(Id_usuario),
    Id_profesional INT NOT NULL REFERENCES Profesional(Id_profesional),
    motivo VARCHAR(255),
    fecha DATE DEFAULT CURRENT_DATE
);