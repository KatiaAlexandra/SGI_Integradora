let data = {};

const getClassroom = async id => {
    await fetch(`http://localhost:8089/SGI_war_exploded/GetClassroomServlet?id=${id}`,{
    method: 'GET',
        headers: {
        'Accept': 'application/json',
            'Content-Type': 'application/json',
    }
}).then(response => response.json()).then(response =>{
    data = response;
    console.log(data);
}).catch(error =>{
    console.log(error);
});
}

const putClassroomInformation = async id => {
    await getClassroom(id);
    document.getElementById("u_id").value = data.classroom_id;
    document.getElementById("u_aula").value = data.classroom_name;
    document.getElementById("u_building").value = data.building.building_ID;
}

const putIdOnForm = async id => {
    await getClassroom(id);
    document.getElementById('d_id').value = data.classroom_id;
    document.getElementById('d_building').textContent = data.building.building_name;
    document.getElementById('d_classroom').textContent = data.classroom_name;
}

const getUser = async id => {
    await fetch(`http://localhost:8089/SGI_war_exploded/GetUserServlet?id=${id}`,{
    method: 'GET',
        headers: {
        'Accept': 'application/json',
            'Content-Type': 'application/json',
    }
}).then(response => response.json()).then(response =>{
    data = response;
    console.log(data);
}).catch(error =>{
    console.log(error);
});
}


const putUserInformation = async id => {
    await getUser(id);
    document.getElementById("u_id").value = data.id;
    document.getElementById("u_username").value = data.username;
    document.getElementById("u_email").value = data.email;
}

const putUserIdOnForm = async id => {
    await getUser(id);
    document.getElementById('d_id').value = data.id;
    document.getElementById('d_username').textContent = data.username;
}


const getManager = async id => {
    await fetch(`http://localhost:8089/SGI_war_exploded/GetManagerServlet?id=${id}`,{
    method: 'GET',
        headers: {
        "Accept": "application/json",
            "Content-Type": "application/json",
    }
}).then(response => response.json()).then(response =>{
    data = response;
    console.log(response);
}).catch(error =>{
    console.log(error);
});
}

const putManagerInformation = async id => {
    await getManager(id);
    document.getElementById("u_id").value = data.Manager_ID;
    document.getElementById("u_nombre1A").value =data.First_Name;
    document.getElementById("u_nombre2A").value = data.Second_Name;
    document.getElementById("u_apellido1A").value = data.First_Lastname;
    document.getElementById("u_apellido2A").value = data.Second_Lastname;
    document.getElementById("u_numEmpleado").value = data.Employee_Num;
    document.getElementById("u_fechaResguardo").value = data.Custody_date;
}

const putMangDeleteIdOnForm = async id =>{
    await getManager(id);
    document.getElementById('d_id').value = id;
    document.getElementById("d_username").textContent = data.First_Name + " " +data.Second_Name+ " " + data.First_Lastname + " " + data.Second_Lastname;
}

const putMangChangeIdOnForm = async id =>{
    await getManager(id);
    document.getElementById( 'ch_id').value = id;
    document.getElementById("ch_username").textContent = data.First_Name + " " +data.Second_Name+ " " + data.First_Lastname + " " + data.Second_Lastname;
}

const getArticle = async id => {
    await fetch(`http://localhost:8089/SGI_war_exploded/GetArticleServlet?id=${id}`,{
    method: 'GET',
        headers: {
        "Accept": "application/json",
            "Content-Type": "application/json"
    }
}).then(response => response.json()).then(response =>{
    data = response;
    console.log(response);
}).catch(error =>{
    console.log(error);
});
}

const putArticleInformation = async id => {
    await getArticle(id);
    document.getElementById("u_id").value = data.article_id;
    document.getElementById("u_inventory_number").value = data.inventory_number;
    document.getElementById("u_article_name").value = data.article_name;
    document.getElementById("u_brand_model").value= (!data.brand_model) ? "S/M" : data.brand_model;
    document.getElementById("u_serial_num").value= (!data.serial_num) ? "S/N" : data.serial_num;
    document.getElementById("u_specifications").value = (!data.specifications) ? "S/E" : data.specifications;
    document.getElementById("u_manager").value = data.manager.Manager_ID;
}

const putArticleIdOnForm = async id => {
    await getArticle(id);
    document.getElementById("d_id").value = data.article_id;
    document.getElementById("d_inventory_number").textContent = data.inventory_number;
    document.getElementById("d_article_name").textContent = data.article_name;
}

const getClassrooms = async () => {
    try {
        const response = await fetch('http://localhost:8089/SGI_war_exploded/GetClassroomsServlet', {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
            }
        });
        data = await response.json();
        return data;
    } catch (error) {
        console.log(error);
        return null;
    }
};



document.addEventListener('DOMContentLoaded', async (event) => {
    const selectEdificio = document.getElementById('edificio');
    const selectAula = document.getElementById('aula');
    const selectUEdificio = document.getElementById('u_edificio'); // Selección para 'u_edificio'
    const selectUAula = document.getElementById('u_aula'); // Selección para 'u_aula'

    const data = await getClassrooms();
    const opciones = {};
    const opcionesUEdificio = {}; // Opciones para 'u_edificio'
    const opcionesUAula = {}; // Opciones para 'u_aula'

    if (data) {
        data.forEach(element => {
            const buildingId = element.building.building_ID;
            if (!opciones[buildingId]) {
                opciones[buildingId] = [];
            }
            opciones[buildingId].push({ value: element.classroom_id, text: element.classroom_name });

            // Agregar a opciones para 'u_edificio'
            if (!opcionesUEdificio[buildingId]) {
                opcionesUEdificio[buildingId] = [];
            }
            opcionesUEdificio[buildingId].push({ value: element.classroom_id, text: element.classroom_name });

            // Agregar a opciones para 'u_aula'
            if (!opcionesUAula[element.classroom_id]) {
                opcionesUAula[element.classroom_id] = [];
            }
            opcionesUAula[element.classroom_id].push({ value: element.classroom_id, text: element.classroom_name });
        });
    }

    selectEdificio.addEventListener('change', (event) => {
        const valorSeleccionado = event.target.value;

        selectAula.innerHTML = '<option value="">--Selecciona una opción--</option>';

        if (opciones[valorSeleccionado]) {
            opciones[valorSeleccionado].forEach(opcion => {
                const newOption = document.createElement('option');
                newOption.value = opcion.value;
                newOption.text = opcion.text;
                selectAula.appendChild(newOption);
            });
        }
    });

    selectUEdificio.addEventListener('change', (event) => {
        const valorSeleccionado = event.target.value;
        selectUAula.innerHTML = '';
        selectUAula.innerHTML = '<option value="">--Selecciona una opción--</option>';

        if (opcionesUEdificio[valorSeleccionado]) {
            opcionesUEdificio[valorSeleccionado].forEach(opcion => {
                const newOption = document.createElement('option');
                newOption.value = opcion.value;
                newOption.text = opcion.text;
                selectUAula.appendChild(newOption);
            });
        }
    });
});

