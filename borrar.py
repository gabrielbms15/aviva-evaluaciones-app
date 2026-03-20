import re

def generar_query(ruta_txt):
    # 🔹 Mapeo areaId -> nombre real (como en tu tabla)
    area_map = {
        'cx_ext': 'Consulta Externa',
        'cx_obs': 'Centro Obstétrico',
        'cx_quir': 'Centro Quirúrgico',
        'hosp': 'Centro Hospitalización',
        'uci': 'Centro Cuidados Intensivos',
        'lab': 'Centro Patología Clínica (Laboratorio)',
        'anatomia': 'Anatomía Patológica',
        'imagen': 'Diagnóstico por Imágenes',
        'rehab': 'Medicina de Rehabilitación',
        'nutricion': 'Nutrición y Dietética',
        'hemot': 'Centro de Hemoterapia y Banco de Sangre',
        'esteril': 'Central de Esterilización',
        'farmacia': 'Farmacia',
        'emerg': 'Emergencia',
    }

    # 🔹 Mapeo sedeId -> nombre real
    sede_map = {
        'lima_centro': 'Lima Centro',
        'los_olivos': 'Los Olivos'
    }

    # 🔹 Tabla UUID (clave: (nombre, sede))
    uuid_map = {
        ('Consulta Externa', 'Lima Centro'): 'e72a7f8a-4399-4b6a-9b9f-72adb230e3dc',
        ('Consulta Externa', 'Los Olivos'): 'b65ecf53-d349-4119-bea6-45313b9a5459',
        ('Centro Obstétrico', 'Lima Centro'): '768c7798-569d-4336-8281-b4aac749e6ef',
        ('Centro Obstétrico', 'Los Olivos'): '0f4aa92b-0c82-42aa-8096-af3176155a3a',
        ('Centro Quirúrgico', 'Lima Centro'): 'df0073d4-8517-4dd6-98cb-a0651b31e0e6',
        ('Centro Quirúrgico', 'Los Olivos'): '6b0a59f7-00b4-4a17-9fe4-fa6f16c1ebb4',
        ('Centro Hospitalización', 'Lima Centro'): 'b3192dcf-7b1b-4861-8d99-fd1ac95758e8',
        ('Centro Hospitalización', 'Los Olivos'): '4ae2b5ae-aadb-4430-a725-541db0b4cfa7',
        ('Centro Cuidados Intensivos', 'Lima Centro'): '41f14bda-6999-49c2-a6a2-09d4bd2badff',
        ('Centro Cuidados Intensivos', 'Los Olivos'): '87689b3a-011b-44b1-b94b-885502c93999',
        ('Centro Patología Clínica (Laboratorio)', 'Lima Centro'): 'c949d37f-c917-4410-a9b5-54990be5a673',
        ('Centro Patología Clínica (Laboratorio)', 'Los Olivos'): '1ed2a0e5-e4b5-471c-9b33-0a8891a87147',
        ('Anatomía Patológica', 'Lima Centro'): '4ffa9e09-ebb6-4cf6-95db-514a7fb7580b',
        ('Anatomía Patológica', 'Los Olivos'): 'f17dc61b-753e-4f10-b0b4-5ad6d830bab1',
        ('Diagnóstico por Imágenes', 'Lima Centro'): '2fe8d0e0-6388-4d2a-9fea-5e1886b428df',
        ('Diagnóstico por Imágenes', 'Los Olivos'): '8a0310f5-f2b3-438d-8cc6-1358eddbedbf',
        ('Medicina de Rehabilitación', 'Lima Centro'): '70fe2c92-14ed-4d78-a441-094593914f3e',
        ('Medicina de Rehabilitación', 'Los Olivos'): '9800b8ec-7875-47ed-b9e4-c926fde54814',
        ('Nutrición y Dietética', 'Lima Centro'): 'fb7b3b1f-643b-4c6f-bc40-2385025120cc',
        ('Nutrición y Dietética', 'Los Olivos'): '3f14af25-f180-4d10-b0a3-e3b95d04798c',
        ('Centro de Hemoterapia y Banco de Sangre', 'Lima Centro'): '62995b7c-fb34-4886-a2c9-3963040b8110',
        ('Centro de Hemoterapia y Banco de Sangre', 'Los Olivos'): 'fca151a8-a417-4a64-b6ec-376febd716fc',
        ('Central de Esterilización', 'Lima Centro'): 'd12ee25f-bd5f-49e4-b0a6-a9eafa9b7ec4',
        ('Central de Esterilización', 'Los Olivos'): '1d86632a-443b-4cf6-9127-b4c6be28e7b2',
        ('Farmacia', 'Lima Centro'): '1f092a1e-b55c-4922-b4c5-9a53d5b4af91',
        ('Farmacia', 'Los Olivos'): '723c3b36-b68a-41af-85ef-48b0d719d774',
        ('Emergencia', 'Lima Centro'): '2a91d416-57e7-494c-bc24-4044b8ddd3a7',
        ('Emergencia', 'Los Olivos'): 'aeddaec9-2c67-45ff-a49a-2ba3564d77fa',
    }

    # 🔹 Leer archivo
    with open(ruta_txt, 'r', encoding='utf-8') as f:
        contenido = f.read()

    # 🔹 Regex para extraer datos
    pattern = re.findall(
        r"sedeId:\s*'([^']+)'.*?areaId:\s*'([^']+)'.*?name:\s*'([^']+)'.*?role:\s*'([^']+)'",
        contenido,
        re.DOTALL
    )

    values = []

    for sede_id, area_id, nombre, rol in pattern:
        sede = sede_map.get(sede_id)
        area_nombre = area_map.get(area_id)

        if not sede or not area_nombre:
            print(f"⚠️ No match: {sede_id}, {area_id}")
            continue

        uuid = uuid_map.get((area_nombre, sede))

        if not uuid:
            print(f"⚠️ UUID no encontrado: {area_nombre}, {sede}")
            continue

        values.append(f"('{uuid}', '{nombre}', '{rol}')")

    # 🔹 Construir query final
    query = "INSERT INTO empleados (area_id, nombre, cargo) VALUES\n"
    query += ",\n".join(values) + ";"

    return query


# 🔥 USO
query = generar_query("staff.txt")
print(query)