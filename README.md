# Azure VM Monitoring & Auto-Remediation Lab



This project demonstrates a complete observability and auto-remediation setup for Azure Virtual Machines using Azure Monitor.



## 🚀 What this project covers



- Azure Monitor Agent (AMA)

- Log Analytics Workspace

- VM Insights

- Metric Alerts (CPU, Network)

- Log Alerts (Heartbeat, Port availability)

- Resource Health Alerts

- Action Groups

- Azure Automation Runbooks (auto-restart)

- Azure Workbooks (dashboard & incident view)



## 🧠 Scenarios implemented



- High CPU usage alert

- VM not responding (missing heartbeat)

- Critical port not listening (RDP/SSH/HTTP)

- Resource health degradation

- Automatic VM restart when connectivity is lost



## 🏗️ Architecture



Azure VM → Azure Monitor Agent → Log Analytics  

→ Alerts → Action Group → Automation Runbook → Restart VM  

→ Workbook shows status & history



## 📊 Key features



- Centralized monitoring for multiple VMs

- Automated recovery (self-healing)

- KQL-based analytics

- Interactive dashboards (Workbooks)



## ⚙️ Technologies



- Azure Monitor

- Log Analytics

- Azure Automation

- KQL (Kusto Query Language)

- Terraform (optional)



## 📌 Use case



This project simulates real-world cloud operations:

monitoring infrastructure, detecting failures, and automatically remediating issues.



---



## 📷 Screenshots



(put here workbook / alerts / runbook execution)



---



## 🔧 Deployment



1. Create Log Analytics Workspace

2. Deploy 2–3 VMs

3. Install Azure Monitor Agent

4. Enable VM Insights

5. Configure alerts

6. Create action groups

7. Deploy automation runbook

8. Import workbook



---



## 🔐 Security



- Managed Identity used for Automation

- Least privilege RBAC applied

- No hardcoded credentials



---



## 💡 Future improvements



- Integration with Azure Functions

- ITSM integration (ServiceNow)

- Auto-scale instead of restart

- Application Insights integration



