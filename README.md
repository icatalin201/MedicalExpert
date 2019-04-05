# MedicalExpert
### Expert System for Medical Diagnosis

MedicalExpert is an Expert Desktop desktop application that has the primary purpose of enabling auto diagnosis for users regardless of their medical knowledge. 

The main modules of the application are the diagnostic module (composed of the respiratory module and the digestive module) and the personal assistant module. 

The diagnostic module is based on the knowledge base built in CLIPS. The knowledge base contains rules and facts used to query the user and identify the condition. The mechanism of operation is quite simple: it starts from the premise that the user is healthy and, as it is interrogated, it looks for possible affections. Depending on the answers he gave questions can vary, so once found a suspect symptom, go on that branch in the tree symptoms. Each symptom has a numerical value (weight) that is its importance for a diagnostic. This weight can take values ​​in the range [0.10], where 0 is the least significant and 10 most significant. When a diagnosis is found, its percentage is calculated in the case which percentage is greater than 30%, it is immediately assigned to the user. 

Once the diagnosis has been identified, get in scene "Personal Assistant" function. It introduces the diagnosis found in the database and also it also creates a user's history from the point of view of its affections. Another functionality is searching and displaying the user of the recommendations available for the affection found. Also, 3 days after the last test, a notification is generated that brings the patient to the fact that he should resume testing in order to verify the improvement of his situation. 

## Mechanism of operation
An id is set for each question. Initially, id has a value of 1, so the first selected question is the one with id 1. As the user responds, the id value changes according to its responses and the query is selected based on the id value. Based on responses, symptoms are introduced in the knowledge base. Symptoms are also assigned values ​​that represent the importance of a particular diagnosis. Based on knowledge, rules are defined to identify a diagnosis and when found, the percentage is calculated and displayed. If the percentage is not more than 30%, the process continues. The query process stops. Enter the results in the database and extract the recommendations. Information about his condition is brought to the attention of the user.
