
# Etapa 1: Construir a aplicação
FROM node:18-alpine AS builder

# Definir o diretório de trabalho
WORKDIR /app

# Copiar os arquivos do package.json e package-lock.json
COPY package*.json ./

# Instalar as dependências
RUN npm install

# Copiar o restante dos arquivos para o diretório de trabalho
COPY . .

# Construir a aplicação
RUN npm run build

# Etapa 2: Servir os arquivos estáticos com um servidor leve
FROM nginx:alpine

# Copiar o build da etapa anterior para o diretório do Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Copiar a configuração personalizada do Nginx (opcional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expor a porta
EXPOSE 80

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]
