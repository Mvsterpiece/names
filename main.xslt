<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="search"></xsl:param>
    <xsl:param name="showRegistrationForm"></xsl:param>

    <xsl:template match="/">
        <html>
            <head>
                <title>Nimede pakkumise teenus</title>
                <style>
                    body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    margin: 20px;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                    margin-top: 50px;
                    background-color: #f5f5f5;
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
                    border: 1px solid #ddd;
                    background-color: #fff;
                    }

                    th, td {
                    border: 1px solid #ddd;
                    padding: 10px;
                    text-align: left;
                    }

                    th {
                    background-color: #f2f2f2;
                    }

                    input[type="text"], input[type="submit"] {
                    padding: 8px;
                    margin-bottom: 10px;
                    border: 1px solid #ddd;
                    }

                    input[type="submit"] {
                    padding: 8px 12px;
                    background-color: #4CAF50;
                    color: #fff;
                    border: none;
                    cursor: pointer;
                    margin-left: 5px;
                    }

                    input[type="submit"]:hover {
                    background-color: #45a049;
                    }

                    .registration-button {
                    padding: 8px 12px;
                    background-color: #808080;
                    color: #fff;
                    border: none;
                    cursor: pointer;
                    margin-bottom: 10px;
                    }

                    .registration-form {
                    display: none;
                    }

                    button {
                    padding: 8px 12px;
                    background-color: #4285f4;
                    color: #fff;
                    border: none;
                    cursor: pointer;
                    margin-bottom: 10px;
                    }

                    button:hover {
                    background-color: #1967D2;
                    }

                    table {
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }


                    .xml-json-button {
                    padding: 8px 12px;
                    background-color: #808080;
                    color: #fff;
                    border: none;
                    cursor: pointer;
                    margin-bottom: 10px;
                    margin-left: 5px;
                    }

                    .xml-json-button:hover {
                    background-color: #808080;
                    }
                </style>

                <script>

                    function toggleRegistrationForm() {
                    var registrationForm = document.getElementById("registrationForm");
                    registrationForm.style.display = registrationForm.style.display === "none" ? "block" : "none";
                    }

                    function deletePerson(personId) {
                    alert('Deleting person with ID: ' + personId);
                    }
                    function openLink() {
                    window.location.href = 'data.xml';
                    }
                    function openJSON() {
                    window.location.href = 'data.json';
                    }
                </script>
            </head>
            <body>
                <h2>Nimede pakkumise teenus</h2>
                <div class="button-container">
                    <button class="xml-json-button" onclick="openLink()">Ava xml</button>
                    <button class="xml-json-button" onclick="openJSON()">Ava JSON</button>
                </div>
                <form>
                    <input type="text" name="search" placeholder="Otsi..." />
                    <input type="submit" value="Otsi" />
                </form>

                <button class="registration-button" onclick="toggleRegistrationForm()">Register</button>

                <div id="registrationForm" class="registration-form">
                    <form id="addPersonForm" method="post">
                        <input type="text" name="newName" placeholder="Nimi" /><br />
                        <input type="text" name="newGender" placeholder="Sugu" /><br />
                        <input type="text" name="newNative" placeholder="Emakeelne nimi" /><br />
                        <input type="text" name="newForeign" placeholder="Võõrkeelne nimi" /><br />
                        <input type="submit" value="Lisa inimese" />
                    </form>
                </div>

                <xsl:choose>
                    <xsl:when test="string-length(normalize-space($search)) > 0">
                        <table>
                            <tr>
                                <th>Nimi</th>
                                <th>Sugu</th>
                                <th>Emakeelne nimi</th>
                                <th>Võõrkeelne nimi</th>
                                <th>Tegevus</th>
                            </tr>
                            <xsl:apply-templates select="data/person[contains(nativeName, normalize-space($search))]"/>
                        </table>
                    </xsl:when>
                    <xsl:otherwise>
                        <table>
                            <tr>
                                <th>Nimi</th>
                                <th>Sugu</th>
                                <th>Emakeelne nimi</th>
                                <th>Võõrkeelne nimi</th>
                                <th>Tegevus</th>
                            </tr>
                            <xsl:apply-templates select="data/person"/>
                        </table>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/data">
        <tr>
            <th>Nimi</th>
            <th>Sugu</th>
            <th>Emakeelne nimi</th>
            <th>Võõrkeelne nimi</th>
            <th>Tegevus</th>
        </tr>
        <xsl:apply-templates select="person"/>
    </xsl:template>

    <xsl:template match="/data/person">
        <tr>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="gender"/></td>
            <td><xsl:value-of select="nativeName"/></td>
            <td><xsl:value-of select="foreignName"/></td>
            <td><a href="?deleteId={id}">Kustutada</a></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
