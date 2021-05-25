from flask import Flask, jsonify, request
import json
import requests
from bs4 import BeautifulSoup
from os import environ

response = ''

app = Flask(__name__)

@app.route('/luv', methods=["GET"])
def check():
    return "hello world"

@app.route('/', methods=["POST"])
def notnameRoute():
    global response
    if request.method == "POST":
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        name = request_data['name']
        url = "https://www.flipkart.com/search?q="+name
        try:
            # Finding the first product
            content = requests.get(url)
            htmlcontent = content.content
            soup = BeautifulSoup(htmlcontent, 'html.parser')

            # Find product name
            pname = soup.find('div', class_='_4rR01T').getText()

            # clicking the first product
            contente = soup.find('a', class_="_1fQZEK")
            url2 = "https://www.flipkart.com"+contente['href']
            content = requests.get(url2)
            htmlcontent = content.content
            soup = BeautifulSoup(htmlcontent, 'html.parser')

            # building temparay storage for customes
            title_list = []
            reviews_list = []
            points_list = []
            names_list = []

            # Building  of url of reviews section
            contente = soup.find('div', class_='_3UAT2v _16PBlm')
            url3 = "https://www.flipkart.com"+contente.parent['href']+'&page='

            # Scanning each page of flipkart Review page
            for i in range(1, 5):

                # opening the ith review page of flipkart
                url_rev = url3+str(i)
                content = requests.get(url_rev)
                htmlcontent = content.content
                soup = BeautifulSoup(htmlcontent, 'html.parser')

                # Find the average points
                avgpoints = soup.find('div', class_='_2d4LTz').getText()

                # access title of reviews of each flipkart page
                title = soup.findAll('p', class_="_2-N8zT")
                for i in title:
                    title_list.append(i.getText())

                # access points of reviews of each flipkart page
                points = soup.findAll('div', class_="_3LWZlK _1BLPMq")
                for i in points:
                    points_list.append(i.getText())

                # access product experience of reviews of each flipkart page
                reviews = soup.findAll('div', class_='t-ZTKy')
                for i in range(len(reviews)):
                    reviews_list.append(reviews[i].find(
                        'div', class_="").find('div', class_="").getText())

                # access reviewer name of reviews of each flipkart page
                names = soup.findAll('p', class_="_2sc7ZR _2V5EHH")
                for i in names:
                    names_list.append(i.getText())

            # Storing all the details in the form of dictionary so that it can be used as json
            m = []
            for i in range(len(points_list)):
                d = {}
                d['name'] = names_list[i]
                d['title'] = title_list[i]
                d['point'] = points_list[i]
                d['reviews'] = reviews_list[i]
                m.append(d)
            result = {"prod_name": pname, "average": avgpoints, "product": m}
            return jsonify(json.dumps(result))
        except:
            return "Error"

if __name__=="__main__":
    app.run('0.0.0.0',port=9000)
