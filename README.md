# Lab work #2
**Implementation of web application from [lab work #1](https://github.com/foliageh/itmo-web-lab1) using Java, Servlets and JSP.**  
Java, Servlets, JSP, WildFly, JavaScript.

> [How to deploy on Helios?](#get-started)

## Task
Разработать веб-приложение на базе сервлетов и JSP,
определяющее попадание точки на координатной плоскости в заданную область.

Приложение должно быть реализовано в соответствии с шаблоном MVC и состоять из следующих элементов:

- **ControllerServlet**, определяющий тип запроса, и, в зависимости от того, содержит ли запрос информацию о координатах
  точки и радиусе, делегирующий его обработку одному из перечисленных ниже компонентов. Все запросы внутри приложения
  должны передаваться этому сервлету (по методу GET или POST в зависимости от варианта задания), остальные сервлеты с
  веб-страниц напрямую вызываться не должны.
- **AreaCheckServlet**, осуществляющий проверку попадания точки в область на координатной плоскости и формирующий
  HTML-страницу с результатами проверки. Должен обрабатывать все запросы, содержащие сведения о координатах точки и
  радиусе области.
- **Страница JSP**, формирующая HTML-страницу с веб-формой. Должна обрабатывать все запросы, не содержащие сведений о
  координатах точки и радиусе области.

**Разработанная страница JSP должна содержать:**
1. "Шапку", содержащую ФИО студента, номер группы и номер варианта.
2. Форму, отправляющую данные на сервер.
3. Набор полей для задания координат точки и радиуса области в соответствии с вариантом задания.
4. Сценарий на языке JavaScript, осуществляющий валидацию значений, вводимых пользователем в поля формы.
5. Интерактивный элемент, содержащий изображение области на координатной плоскости (в соответствии с вариантом задания)
   и реализующий следующую функциональность:
    - Если радиус области установлен, клик курсором мыши по изображению должен обрабатываться JavaScript-функцией,
      определяющей координаты точки, по которой кликнул пользователь и отправляющей полученные координаты на сервер для
      проверки факта попадания.
    - В противном случае, после клика по картинке должно выводиться сообщение о невозможности определения координат
      точки.
    - После проверки факта попадания точки в область изображение должно быть обновлено с учётом результатов этой
      проверки (т.е., на нём должна появиться новая точка).
6. Таблицу с результатами предыдущих проверок. Список результатов должен браться из контекста приложения, HTTP-сессии
   или Bean-компонента в зависимости от варианта.

**Страница, возвращаемая AreaCheckServlet, должна содержать:**
1. Таблицу, содержащую полученные параметры.
2. Результат вычислений - факт попадания или непопадания точки в область.
3. Ссылку на страницу с веб-формой для формирования нового запроса.

Разработанное веб-приложение необходимо развернуть на сервере WildFly.
Сервер должен быть запущен в standalone-конфигурации,
порты должны быть настроены в соответствии с выданным portbase,
доступ к http listener'у должен быть открыт для всех IP.

## Get started
1. Создать в IDEA проект Maven с архетипом webapp.
2. Отредактировать содержимое pom.xml.
``` xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>web.twillice</groupId>
  <artifactId>lab2</artifactId>
  <packaging>war</packaging>
  <properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
  </properties>
  <version>1.0-SNAPSHOT</version>
  <name>lab2 Maven Webapp</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
      <groupId>javax</groupId>
      <artifactId>javaee-web-api</artifactId>
      <version>7.0</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>jstl</groupId>
      <artifactId>jstl</artifactId>
      <version>1.2</version>
    </dependency>
  </dependencies>
  <build>
    <finalName>lab2</finalName>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <configuration>
          <source>9</source>
          <target>9</target>
        </configuration>
        <version>3.10.1</version>
      </plugin>
    </plugins>
  </build>
</project>
```
3. В директории src/main/java создать класс HelloWorldServlet.
``` java
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/controller")
public class HelloWorldServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
```
4. `mvn clean install` - для сборки проекта (файл `lab2.war` будет лежать в папке `target`). Можно через IDEA, из панели справа.
5. Скачать WildFly: https://download.jboss.org/wildfly/21.0.0.Final/wildfly-21.0.0.Final.zip. Распаковать в любую директорию.
6. Отредактировать содержимое файла `wildfly-21.0.0.Final\standalone\configuration\standalone.xml`.
- Изменить
   ``` xml
    <interface name="public">
        <inet-address value="${jboss.bind.address:127.0.0.1}" />
    </interface>
   ```  
  на
   ``` xml
    <interface name="public">
        <any-address/>
    </interface>
   ```  
- И изменить порты на свой portbase следющим образом (на примере portbase=22288):
   ``` xml
    <socket-binding name="ajp" port="${jboss.ajp.port:8009}"/>
    <socket-binding name="http" port="${jboss.http.port:8080}"/>
    <socket-binding name="https" port="${jboss.https.port:8443}"/>
    <socket-binding name="management-http" interface="management" port="${jboss.management.http.port:9990}"/>
    <socket-binding name="management-https" interface="management" port="${jboss.management.https.port:9993}"/>
   ```  
  на
   ``` xml
    <socket-binding name="ajp" port="${jboss.ajp.port:22289}"/>
    <socket-binding name="http" port="${jboss.http.port:22288}"/>
    <socket-binding name="https" port="${jboss.https.port:22290}"/>
    <socket-binding name="management-http" interface="management" port="${jboss.management.http.port:22291}"/>
    <socket-binding name="management-https" interface="management" port="${jboss.management.https.port:22292}"/>
   ``` 
7. Закинуть папку `wildfly-21.0.0.Final` в свою домашнюю директорию на helios.
8. Закинуть `lab2.war` в папку `~/wildfly-21.0.0.Final/standalone/deployments/` на helios.
9. Запустить сервер на helios командой `bash ~/wildfly-21.0.0.Final/bin/standalone.sh`.
10. Прокинуть порты с helios на локалку, например, командой `plink.exe -batch -ssh s123456@se.ifmo.ru -pw password -P 2222 -L 22288:helios.cs.ifmo.ru:22288`.
11. Открыть в браузере http://localhost:22288/lab2/controller.
12. Повторить пункты 4 и 8 (плюс иногда 9-11) всякий раз, когда требуется проверить работоспособность написанного приложения.
13. Если серверу будет не хватать памяти для запуска, на helios можно выполнить команду `killall -u s123456`.