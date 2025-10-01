# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY *.sln .
COPY APITempoDIO.csproj ./
RUN dotnet restore "APITempoDIO.csproj"

# Copy everything else and build
COPY . .
RUN dotnet publish "APITempoDIO.csproj" -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Expose port (adjust if your app uses a different port)
EXPOSE 5068

# Run the application
ENTRYPOINT ["dotnet", "APITempoDIO.dll"]
