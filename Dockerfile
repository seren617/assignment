########################
### Assignment for Loco
########################

# Stage 1>> Build stage
FROM python:3.11-alpine as build

WORKDIR /app

# build-base provides the necessary build tools required to compile in alpine images
RUN apk add --no-cache build-base  

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Stage 2>> Runtime stage
FROM python:3.11-alpine as runtime

WORKDIR /app

# Copy the Python dependencies from the build stage
COPY --from=build /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /app /app

EXPOSE 80

CMD ["python", "app.py"]
