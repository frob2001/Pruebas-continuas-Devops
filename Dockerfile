# Imagen base para Python
FROM python:3.9-slim

# Instalar Node.js para el frontend
RUN apt-get update && apt-get install -y curl && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs

# Configurar directorio de trabajo
WORKDIR /app

# Copiar y preparar backend
COPY backend /app/backend
RUN pip install -r backend/requirements.txt

# Copiar y preparar frontend
COPY frontend /app/frontend
RUN cd /app/frontend && npm install && npm run build

# Exponer el puerto y ejecutar Flask
EXPOSE 5000
CMD ["python", "backend/app.py"]
