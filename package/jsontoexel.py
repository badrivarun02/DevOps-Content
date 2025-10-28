import pandas as pd
import json

json_file_path = 'trivy_petclinicimg.json'
excel_file_path = 'trivy_report.xlsx'

# Load the JSON data
with open(json_file_path, 'r') as f:
    data = json.load(f)

# Trivy reports often contain a list of results under the 'Results' key.
# The actual vulnerabilities are nested within these results.
all_vulnerabilities = []

for result in data.get('Results', []):
    for vulnerability in result.get('Vulnerabilities', []):
        # Add package name and other context from the result for better reporting
        vulnerability['Target'] = result.get('Target', 'N/A')
        vulnerability['Type'] = result.get('Type', 'N/A')
        all_vulnerabilities.append(vulnerability)

# Create a DataFrame from the flattened list of vulnerabilities
if all_vulnerabilities:
    df = pd.DataFrame(all_vulnerabilities)

    # Select and reorder relevant columns for clarity
    relevant_cols = [
        'Target', 'VulnerabilityID', 'PkgName', 'InstalledVersion', 
        'FixedVersion', 'Severity', 'Description', 'PrimaryURL', 'Type'
    ]

    # Ensure all columns exist before selecting them, filling missing with 'N/A'
    for col in relevant_cols:
        if col not in df.columns:
            df[col] = 'N/A'

    df = df[relevant_cols]

    # Write the DataFrame to an Excel file
    df.to_excel(excel_file_path, index=False)
    print(f"Successfully converted '{json_file_path}' to '{excel_file_path}'")
else:
    print("No vulnerabilities found to generate a report.")
