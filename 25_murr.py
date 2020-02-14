import requests
from bs4 import BeautifulSoup as bs
headers = {'accept': '*/*',
           'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.100 Safari/537.36'}
base_url = 'https://hyperauto.ru'
def region_parse(base_url, headers):
    session = requests.Session()
    request = session.get(base_url, headers=headers)
    if request.status_code == 200:
        soup = bs(request.content, 'html.parser')
        divs = soup.find_all('div', attrs={'class': 'collection__item'})
        for div in divs:
            title = div.find('a', attrs={'class': 'article-item__title-link link link_full'}).text
            href = div.find('a', attrs={'class': 'article-item__title-link link link_full'})['href']
            company =

            print(href)
    else:
        print('ERROR')

region_parse(base_url, headers)

