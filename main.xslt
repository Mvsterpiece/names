<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="search"></xsl:param>
    <xsl:param name="showRegistrationForm"></xsl:param>

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
                    margin-bottom: 10px; /* Add spacing between input fields */
                    }

                    input[type="submit"] {
                    padding: 5px 10px;
                    background-color: #4CAF50;
                    color: #fff;
                    border: none;
                    cursor: pointer;
                    margin-bottom: 10px; /* Add spacing between button and input fields */
                    margin-left: 5px; /* Add left margin to create space between the search input and button */
                    }

                    input[type="submit"]:hover {
                    background-color: #45a049;
                    }

                    .registration-button {
                    padding: 5px 10px;
                    background-color: #808080;
                    color: #fff;
                    border: none;
                    cursor: pointer;
                    margin-bottom: 10px; /* Add spacing between button and input fields */
                    }

                    .registration-form {
                    display: none;
                    }
                </style>
                <script>
                    function toggleRegistrationForm() {
                    var registrationForm = document.getElementById("registrationForm");
                    registrationForm.style.display = registrationForm.style.display === "none" ? "block" : "none";
                    }

                    function deletePerson(personId) {
                    // Implement your delete logic here, using personId
                    alert('Deleting person with ID: ' + personId);
                    }
                </script>
            </head>
            <body>
                <h2>Names Data</h2>

                <form>
                    <input type="text" name="search" placeholder="Search..." />
                    <input type="submit" value="Search" />
                </form>

                <button class="registration-button" onclick="toggleRegistrationForm()">Register</button>

                <div id="registrationForm" class="registration-form">
                    <form id="addPersonForm" method="post">
                        <input type="text" name="newName" placeholder="Name" /><br />
                        <input type="text" name="newGender" placeholder="Gender" /><br />
                        <input type="text" name="newNative" placeholder="Native name" /><br />
                        <input type="text" name="newForeign" placeholder="Foreign name" /><br />
                        <input type="submit" value="Add Person" />
                    </form>
                </div>

                <xsl:choose>
                    <xsl:when test="string-length(normalize-space($search)) > 0">
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Native Name</th>
                                <th>Foreign Name</th>
                                <th>Action</th> <!-- Added header for the action column -->
                            </tr>
                            <xsl:apply-templates select="data/person[contains(nativeName, normalize-space($search))]"/>
                        </table>
                    </xsl:when>
                    <xsl:otherwise>
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Native Name</th>
                                <th>Foreign Name</th>
                                <th>Action</th> <!-- Added header for the action column -->
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
            <th>ID</th>
            <th>Name</th>
            <th>Gender</th>
            <th>Native Name</th>
            <th>Foreign Name</th>
            <th>Action</th> <!-- Added header for the action column -->
        </tr>
        <xsl:apply-templates select="person"/>
    </xsl:template>

    <xsl:template match="person">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="gender"/></td>
            <td><xsl:value-of select="nativeName"/></td>
            <td><xsl:value-of select="foreignName"/></td>
            <td><a href="?deleteId={id}">Delete</a></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
