<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Преобразование в HTML -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Names Data</title>
                <style>
                    body {
                    font-family: Arial, sans-serif;
                    margin: 20px;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                    margin-top: 50px; /* Дополнительный отступ сверху */
                    }

                    h2 {
                    color: #333;
                    }

                    form {
                    margin-bottom: 20px;
                    }

                    table {
                    width: 80%;
                    border-collapse: collapse;
                    margin-top: 20px;
                    }

                    th, td {
                    border: 1px solid #ddd;
                    padding: 10px;
                    text-align: left;
                    }

                    th {
                    background-color: #f2f2f2;
                    }

                    input[type="text"] {
                    padding: 5px;
                    }

                    input[type="submit"] {
                    padding: 5px 10px;
                    background-color: #4CAF50;
                    color: #fff;
                    border: none;
                    cursor: pointer;
                    }

                    input[type="submit"]:hover {
                    background-color: #45a049;
                    }
                </style>
            </head>
            <body>
                <h2>Names Data</h2>

                <!-- Форма поиска -->
                <form>
                    <input type="text" name="search" placeholder="Search..." />
                    <input type="submit" value="Search" />
                </form>

                <!-- Применение шаблонов в зависимости от наличия параметра поиска -->
                <xsl:choose>
                    <xsl:when test="string-length(normalize-space($search)) > 0">
                        <!-- Если есть параметр поиска, применяем шаблон для отображения найденных данных -->
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Native Name</th>
                                <th>Foreign Name</th>
                            </tr>
                            <xsl:apply-templates select="data/person[contains(name, normalize-space($search))]"/>
                        </table>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Если параметр поиска отсутствует или пуст, выводим полную таблицу -->
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Native Name</th>
                                <th>Foreign Name</th>
                            </tr>
                            <xsl:apply-templates select="data/person"/>
                        </table>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>

    <!-- Шаблон для отображения заголовка таблицы -->
    <xsl:template match="/data">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Gender</th>
            <th>Native Name</th>
            <th>Foreign Name</th>
        </tr>
    </xsl:template>

    <!-- Шаблон для отображения найденных данных -->
    <xsl:template match="person">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="gender"/></td>
            <td><xsl:value-of select="nativeName"/></td>
            <td><xsl:value-of select="foreignName"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
