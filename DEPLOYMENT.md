# Deployment Guide

This document provides comprehensive instructions for deploying the Consistly application across different environments.

## Overview

The Consistly application uses a modern CI/CD pipeline with automated testing, security scanning, and deployment to both staging and production environments.

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend API   │    │   Database      │
│   (React)       │◄──►│   (FastAPI)     │◄──►│   (PostgreSQL)  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   Monitoring    │
                    │   (Prometheus   │
                    │   + Grafana)    │
                    └─────────────────┘
```

## Environments

### Staging Environment

- **Purpose**: Testing and validation before production
- **Branch**: `develop`
- **URLs**:
  - Frontend: https://staging.consistly-app.com
  - Backend: https://staging-api.consistly-app.com
  - Monitoring: https://staging-monitoring.consistly-app.com

### Production Environment

- **Purpose**: Live application for end users
- **Branch**: `main`
- **URLs**:
  - Frontend: https://consistly-app.com
  - Backend: https://api.consistly-app.com
  - Monitoring: https://monitoring.consistly-app.com

## CI/CD Pipeline

### Pipeline Stages

1. **Security Scanning**

   - Trivy vulnerability scanning
   - Bandit security linter
   - Dependency vulnerability scanning

2. **Testing**

   - Backend unit tests with coverage
   - Frontend unit tests
   - Integration tests
   - Code quality checks

3. **Build & Push**

   - Multi-stage Docker builds
   - Container image security scanning
   - Push to GitHub Container Registry

4. **Deployment**

   - Automatic deployment to staging (develop branch)
   - Automatic deployment to production (main branch)
   - Health checks and rollback capabilities

5. **Monitoring**
   - Prometheus metrics collection
   - Grafana dashboards
   - AlertManager notifications

### Pipeline Triggers

- **Pull Requests**: Security scanning and testing
- **Push to develop**: Deploy to staging
- **Push to main**: Deploy to production

## Deployment Process

### Automated Deployment

The deployment is fully automated through GitHub Actions:

1. **Code Push**: Developer pushes code to `develop` or `main`
2. **Pipeline Execution**: GitHub Actions runs the CI/CD pipeline
3. **Security Checks**: Vulnerability scanning and security linting
4. **Testing**: Unit tests, integration tests, and quality checks
5. **Build**: Docker images are built and pushed to registry
6. **Deploy**: Application is deployed to the target environment
7. **Health Checks**: Automated health checks verify deployment
8. **Monitoring**: Metrics collection and alerting setup

### Manual Deployment

For emergency deployments or troubleshooting:

```bash
# Staging deployment
./scripts/deploy-staging.sh

# Production deployment
./scripts/deploy-production.sh
```

## Monitoring & Observability

### Metrics Collected

- **Application Metrics**:

  - Request count and response times
  - Error rates and status codes
  - API endpoint performance

- **System Metrics**:

  - CPU and memory usage
  - Disk space utilization
  - Network I/O

- **Infrastructure Metrics**:
  - Container health and restart frequency
  - Database connection status
  - Service availability

### Alerts

The following alerts are configured:

- **Critical Alerts**:

  - Service downtime (>1 minute)
  - Database connection failure
  - High error rates (>10%)

- **Warning Alerts**:
  - High CPU usage (>80%)
  - High memory usage (>85%)
  - High response times (>2 seconds)
  - Low disk space (<10%)

### Accessing Monitoring

- **Grafana Dashboard**: https://monitoring.consistly-app.com

  - Username: `admin`
  - Password: `admin` (change in production)

- **Prometheus**: https://monitoring.consistly-app.com:9090
- **AlertManager**: https://monitoring.consistly-app.com:9093

## Health Checks

### Application Health Endpoints

- **Basic Health**: `/health`

  - Returns service status and timestamp
  - Used by load balancers and monitoring

- **Detailed Health**: `/health/detailed`

  - Includes system metrics (CPU, memory, disk)
  - Used for detailed monitoring

- **Metrics**: `/metrics`
  - Prometheus-formatted metrics
  - Used by monitoring systems

### Health Check Commands

```bash
# Backend health check
curl -f http://localhost:8000/health

# Frontend health check
curl -f http://localhost/health

# Database health check
docker-compose exec db pg_isready -U myuser -d mydb
```

## Rollback Process

### Automatic Rollback

The deployment scripts include automatic rollback capabilities:

1. **Health Check Failure**: If health checks fail after deployment
2. **Rollback Trigger**: Previous version is automatically restored
3. **Notification**: Team is notified of the rollback

### Manual Rollback

```bash
# Rollback to previous version
docker-compose down
docker-compose up -d

# Or rollback to specific version
docker-compose down
docker pull ghcr.io/username/consistly_app:previous-version
docker-compose up -d
```

## Security Considerations

### Container Security

- **Base Images**: Using official, minimal base images
- **Security Scanning**: Trivy scans for vulnerabilities
- **Non-root User**: Containers run as non-root users
- **Secrets Management**: Environment variables for sensitive data

### Network Security

- **HTTPS Only**: All external traffic uses HTTPS
- **Security Headers**: Comprehensive security headers
- **Rate Limiting**: API rate limiting to prevent abuse
- **CORS Configuration**: Proper CORS settings

### Access Control

- **Environment Protection**: GitHub environments with approval gates
- **Secrets Management**: GitHub Secrets for sensitive data
- **Audit Logging**: All deployments are logged and auditable

## Troubleshooting

### Common Issues

1. **Deployment Failures**

   - Check GitHub Actions logs
   - Verify environment variables
   - Ensure Docker images are built successfully

2. **Health Check Failures**

   - Check application logs
   - Verify database connectivity
   - Check system resources

3. **Monitoring Issues**
   - Verify Prometheus configuration
   - Check Grafana datasource settings
   - Ensure metrics endpoints are accessible

### Debug Commands

```bash
# Check container status
docker-compose ps

# View application logs
docker-compose logs backend
docker-compose logs frontend

# Check system resources
docker stats

# Test database connectivity
docker-compose exec db psql -U myuser -d mydb -c "SELECT 1;"
```

## Performance Optimization

### Application Optimization

- **Caching**: Implement Redis for session and data caching
- **CDN**: Use CDN for static assets
- **Database**: Optimize queries and add indexes
- **Compression**: Enable gzip compression

### Infrastructure Optimization

- **Load Balancing**: Implement load balancers
- **Auto-scaling**: Configure auto-scaling based on metrics
- **Resource Limits**: Set appropriate resource limits
- **Monitoring**: Continuous performance monitoring

## Backup and Recovery

### Database Backups

```bash
# Create backup
docker-compose exec db pg_dump -U myuser mydb > backup.sql

# Restore backup
docker-compose exec -T db psql -U myuser mydb < backup.sql
```

### Application Backups

- **Configuration**: Version control for all configurations
- **Data**: Regular database backups
- **Images**: Docker images stored in registry
- **Logs**: Centralized logging system

## Support and Maintenance

### Regular Maintenance

- **Security Updates**: Regular security patches
- **Dependency Updates**: Keep dependencies updated
- **Performance Monitoring**: Continuous performance analysis
- **Backup Verification**: Regular backup testing

### Support Contacts

- **Development Team**: For technical issues
- **DevOps Team**: For infrastructure issues
- **Security Team**: For security-related concerns

---

For additional support or questions, please refer to the project documentation or contact the development team.
