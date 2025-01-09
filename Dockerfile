# Imagen base para Python
FROM python:3.9-slim AS backend

# Configuración del backend
WORKDIR /app/backend
COPY backend /app/backend
RUN pip install -r requirements.txt

# Imagen base para Node.js (Frontend)
FROM node:16 AS frontend

# Configuración del frontend
WORKDIR /app/frontend
COPY frontend /app/frontend
RUN npm install && npm run build

# Imagen final para ejecutar la aplicación
FROM python:3.9-slim

# Copiar el backend y frontend ya preparados
WORKDIR /app
COPY --from=backend /app/backend /app/backend
COPY --from=frontend /app/frontend/build /app/frontend/build

# Exponer el puerto
EXPOSE 5000

# Ejecutar la aplicación Flask
CMD ["python", "backend/app.py"]
