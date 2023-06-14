import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
import sys

data = pd.read_excel('c:/xampp/htdocs/proyek3/web-dev/app/Http/Controllers/Klasifikasi/aspirasi.xlsx')
    
X = data['teks']
y = data['label']
    
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(X)
model = MultinomialNB()
model.fit(X, y)

# Mengklasifikasikan teks baru
def predict_category(text):
    text_vectorized = vectorizer.transform([text])
    prediction = model.predict(text_vectorized)
    return prediction[0]

text = sys.argv[1]
predicted_category = predict_category(text)
print(predicted_category)
