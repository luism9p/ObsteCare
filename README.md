# ObsteCare — Sistema Web de Gestión para Consultorio Obstétrico

Proyecto académico (curso *Integrador I: Sistemas – Software*). Avance funcional:
**Login + Dashboard + Módulo de Pacientes (CRUD completo)**, sobre arquitectura
Java EE clásica: **JSP + Servlets + JDBC**, con **PostgreSQL** como base de datos.

- Frontend: HTML5 + CSS3 + JSP (sin frameworks).
- Backend: Servlets Java + JSTL en las vistas.
- Persistencia: JDBC puro con PreparedStatement (sin ORM).
- Contraseñas: guardadas con hash SHA-256 (nunca en texto plano).

---

## Requisitos previos

Antes de nada, instala esto en tu computadora:

1. **JDK 11 o superior** — [Descargar Eclipse Temurin](https://adoptium.net/es/temurin/releases/)
   Verifica con: `java -version`
2. **Apache Maven** — [Descargar Maven](https://maven.apache.org/download.cgi)
   Verifica con: `mvn -version`
3. **Apache Tomcat 9.x** — [Descargar Tomcat 9](https://tomcat.apache.org/download-90.cgi)
   (usa la versión **9**, no la 10+, porque este proyecto usa el paquete `javax.servlet`)
4. **PostgreSQL + pgAdmin 4** — [Descargar PostgreSQL](https://www.postgresql.org/download/)
   pgAdmin normalmente se instala junto con PostgreSQL.

Si vas a trabajar con un IDE (recomendado si no manejas la línea de comandos),
**NetBeans** o **Eclipse IDE for Enterprise Java** permiten importar el proyecto
Maven y registrar un servidor Tomcat 9 con un par de clics, sin usar la terminal.

---

## 1. Clonar el proyecto

```bash
git clone https://github.com/luism9p/ObsteCare.git
cd ObsteCare
```

## 2. Crear la base de datos (con pgAdmin)

1. Abre **pgAdmin 4** y conéctate a tu servidor local de PostgreSQL (te pedirá
   la contraseña que definiste al instalar PostgreSQL).
2. Click derecho en **Databases → Create → Database…**
   - Nombre: `obstecare`
   - Guardar.
3. Click derecho sobre la base `obstecare` → **Query Tool**.
4. Abre el archivo [`sql/schema.sql`](sql/schema.sql) de este proyecto, copia
   todo su contenido, pégalo en el Query Tool y ejecútalo (▶ o F5).

Esto crea las tablas `usuarios` y `pacientes`, y deja precargado:

- Un usuario administrador: **usuario `admin`, contraseña `admin123`**
- 3 pacientes de ejemplo para probar el sistema.

## 3. Configurar la conexión a la base de datos

Abre [`src/main/resources/db.properties`](src/main/resources/db.properties)
y reemplaza `CAMBIA_ESTA_CONTRASENA` por la contraseña real de tu usuario
`postgres` en PostgreSQL:

```properties
db.url=jdbc:postgresql://localhost:5432/obstecare
db.user=postgres
db.password=TU_CONTRASENA_DE_POSTGRES
```

> Si en pgAdmin usas otro puerto, otro usuario, u otro nombre de base de
> datos, ajústalo también en esta línea.

## 4. Compilar y ejecutar

### Opción A — Con un IDE (más fácil, sin usar consola)

1. Abre NetBeans o Eclipse → **File → Open Project / Import → Maven → Existing Maven Project**
   y selecciona la carpeta `ObsteCare`.
2. Registra un servidor **Apache Tomcat 9** en el IDE (Window → Preferences → Server,
   en Eclipse; o Tools → Servers en NetBeans) apuntando a donde descargaste Tomcat.
3. Click derecho sobre el proyecto → **Run on Server**.
4. El IDE compila, empaqueta el WAR y lo despliega automáticamente.

### Opción B — Por línea de comandos

```bash
mvn clean package
```

Esto genera `target/obstecare.war`. Cópialo a la carpeta `webapps/` de tu
instalación de Tomcat 9 y arranca el servidor:

```bash
# Windows
%CATALINA_HOME%\bin\startup.bat

# Linux/Mac
$CATALINA_HOME/bin/startup.sh
```

## 5. Abrir la aplicación

```
http://localhost:8080/obstecare/
```

Inicia sesión con:

- **Usuario:** `admin`
- **Contraseña:** `admin123`

---

## Estructura del proyecto

```
pom.xml                         Configuración Maven (dependencias, empaquetado WAR)
sql/schema.sql                  Script SQL para crear la base de datos en pgAdmin
src/main/java/com/obstecare/
  model/       Usuario.java, Paciente.java
  dao/         ConexionBD.java, UsuarioDAO.java, PacienteDAO.java
  servlet/     LoginServlet, LogoutServlet, DashboardServlet, PacienteServlet
  filter/      AuthFilter.java       (protege /dashboard y /pacientes sin sesión)
  util/        ClaveUtil.java        (hash SHA-256 de contraseñas)
src/main/resources/
  db.properties                 Credenciales de conexión a PostgreSQL
src/main/webapp/
  index.jsp                     Landing pública
  login.jsp, dashboard.jsp, error.jsp
  pacientes/lista.jsp, pacientes/form.jsp
  css/style.css
  WEB-INF/web.xml
```

## Solución de problemas comunes

| Problema | Solución |
|---|---|
| `No se encontro db.properties en el classpath` | Verifica que el archivo esté en `src/main/resources/db.properties` y vuelve a compilar. |
| Error de conexión / `FATAL: password authentication failed` | Revisa usuario y contraseña en `db.properties` contra los de tu PostgreSQL. |
| `404` al abrir `http://localhost:8080/obstecare/` | Confirma que el WAR se llame `obstecare.war` en `webapps/` y que Tomcat haya terminado de desplegar (revisa `logs/catalina.out`). |
| La página se ve sin estilos | Verifica que el navegador no esté bloqueando `css/style.css`; revisa la consola del navegador (F12). |

## Alcance actual

Implementado: **Login, Dashboard y CRUD de Pacientes** (crear, listar, buscar,
editar, eliminar), con autenticación por sesión y control de acceso por filtro.

Pendiente para un siguiente avance (según el documento del proyecto): módulos
de **Citas**, **Controles Obstétricos**, **Historia Clínica** y **Reportes**.
