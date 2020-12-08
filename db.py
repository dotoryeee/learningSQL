'''
파이썬과 db 연동
=> 파이썬은 데이터를 리스트에 담으면 프로그램 종료시 다 날라감
=> 데이터를 영구 보관. => 파이썬에서 사용한 데이터를 db 전달.

cx_Oracle: 라이브러리 먼저 설치. 여기에 오라클과 연동하고 sql을 실행할 수 있는
기능을 구현해 놓은 라이브러리임.

파이썬 db 작업
1. db 연결(커넥션 수립하고 커넥션 객체를 받아옴으로 db 사용이 가능)
cx_Oracle.connect(id, pwd, db주소:리스너번호/xe, encoding):db 연결 함수

2. cursor 객체 생성: 파이썬에서 sql 실행을 담당.
3. 실행하고 싶은 sql 문장을 만든다(문자열)
4. cursor.execute(): sql을 실행하는 함수. 파라메터로 sql을 전달
sql문이 검색이면 검색 결과는 cursor 객체에 저장되므로 이 값을 하나씩
꺼내서 처리하는 구문이 더 필요.
sql 문이 insert, update, delete 라면 이 문장 실행하고 끝
5. connection 끊는다(close())
'''

import cx_Oracle    #oracle api 라이브러리 임포트
class Test:
    def __init__(self, num=None, name=None, price=None, desc=None):
        self.num = num
        self.name = name
        self.price = price
        self.desc = desc

    def print(self):
        print('num:',self.num,'/ name:',self.name,'/ price:',self.price,'/ descript:', self.desc)

#Database access object(db 작업 전담 객체)
class Dao_test:
    def select_all(self):
        #1. db 커넥션 수립
        conn = cx_Oracle.connect("hr", "hr", "localhost:1521/xe", encoding='utf-8')
        cursor = conn.cursor()
        sql = 'select * from test'
        cursor.execute(sql)#sql실행. 실행한 결과는 cursor 객체에 담아
        datas = []
        for row in cursor:
            datas.append(Test(row[0],row[1],row[2],row[3]))
        conn.close()
        return datas
    def select(self, num):
        conn = cx_Oracle.connect("hr", "hr", "localhost:1521/xe", encoding='utf-8')
        cursor = conn.cursor()
        sql = 'select * from test where num=:1'
        d = (num,)
        cursor.execute(sql, d)#sql 1줄 검색 실행
        # 검색 결과에서 한줄 추출. 검색 결과가 없다면 None반환
        row = cursor.fetchone()
        conn.close()
        if row is not None:
            return Test(row[0], row[1], row[2], row[3])

    def insert(self, t):
        conn = cx_Oracle.connect("hr", "hr", "localhost:1521/xe", encoding='utf-8')
        cursor = conn.cursor()
        #실행할 insert문을 생성.
        sql = 'insert into test values(seq_test.nextval, :1, :2, :3)'
        d = (t.name, t.price, t.desc)#위 :1, :2, :3과 매칭 될 값
        #sql 실행.
        cursor.execute(sql, d)
        conn.commit()#쓰기 완료
        conn.close()

    def update(self, t):
        conn = cx_Oracle.connect("hr", "hr", "localhost:1521/xe", encoding='utf-8')
        cursor = conn.cursor()
        sql = 'update test set price=:1, disc=:2 where num=:3'
        d = (t.price, t.desc, t.num)
        cursor.execute(sql, d)
        conn.commit()
        conn.close()

    def delete(self, num):
        conn = cx_Oracle.connect("hr", "hr", "localhost:1521/xe", encoding='utf-8')
        cursor = conn.cursor()
        sql = 'delete test where num=:1'
        d = (num,)
        cursor.execute(sql, d)
        conn.commit()
        conn.close()

class Service:
    def __init__(self):
        self.dao = Dao_test()

    def addProduct(self):
        p = Test()
        p.name = input('제품명:')
        p.price = int(input('제품가격:'))
        p.desc = input('제품 설명:')
        self.dao.insert(p)

    def getProduct(self):
        num = int(input('제품번호:'))
        p = self.dao.select(num)
        if p==None:
            print('없는 제품 번호')
        else:
            p.print()

    def printAll(self):
        datas = self.dao.select_all()
        for i in datas:
            i.print()

    def editProduct(self):
        p = Test()
        p.num = int(input('수정할 제품 번호:'))
        p.price = int(input('new 제품가격:'))
        p.desc = input('new 제품 설명:')
        self.dao.update(p)

    def delProduct(self):
        num = int(input('삭제할 제품 번호:'))
        self.dao.delete(num)

class Menu:
    def __init__(self):
        self.service = Service()

    def run(self):
        while True:
            m = int(input("1.추가 2.검색 3.수정 4.삭제 5.전체출력 6.종료"))
            if m==1:
                self.service.addProduct()
            elif m==2:
                self.service.getProduct()
            elif m==3:
                self.service.editProduct()
            elif m==4:
                self.service.delProduct()
            elif m==5:
                self.service.printAll()
            elif m==6:
                break

def main():
    mm = Menu()
    mm.run()

main()