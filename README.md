# Base de Datos Pizzería

## Diagrama Entidad Relación

```mermaid
erDiagram

    CLIENTE ||--o{ PEDIDO : realiza
    EMPLEADO ||--o{ PEDIDO : atiende
    TIPO_CONSUMO ||--o{ PEDIDO : clasifica

    PEDIDO ||--o{ DETALLE_PEDIDO : contiene
    PEDIDO ||--o{ DETALLE_PEDIDO_BEBIDA : contiene

    PIZZA ||--o{ PIZZA_TAMANO : tiene
    TAMANO ||--o{ PIZZA_TAMANO : define

    BEBIDA ||--o{ BEBIDA_TAMANO : tiene
    TAMANO ||--o{ BEBIDA_TAMANO : define

    PIZZA_TAMANO ||--o{ DETALLE_PEDIDO : vendido
    BEBIDA_TAMANO ||--o{ DETALLE_PEDIDO_BEBIDA : vendido

    PEDIDO ||--|| PAGO : genera
    METODO_PAGO ||--o{ PAGO : utiliza

    CLIENTE ||--o{ FACTURA : recibe
    PEDIDO ||--|| FACTURA : genera
    FACTURA ||--o{ FACTURA_DETALLE : contiene

    CLIENTE ||--|| DATOS_FISCALES : posee

    PROVEEDOR ||--o{ COMPRA_INSUMO : suministra
    EMPLEADO ||--o{ COMPRA_INSUMO : registra

    COMPRA_INSUMO ||--o{ DETALLE_COMPRA : contiene
    INSUMO ||--o{ DETALLE_COMPRA : comprado

    UNIDAD_MEDIDA ||--o{ INSUMO : utiliza

    PROVEEDOR ||--o{ PROVEEDOR_INSUMO : provee
    INSUMO ||--o{ PROVEEDOR_INSUMO : surtido

    ROL ||--o{ EMPLEADO : asignado
```
# Proyecto de Normalización de Base de Datos

## Primera Forma Normal (1FN)

En esta etapa se identificaron las entidades principales de la pizzería y sus atributos.

![Primera Forma Normal](docs/img/1FN.png)

### Entidades identificadas

- Cliente
- Empleado
- Pizza
- Pedido
- Proveedor
- Insumo

---

## Segunda Forma Normal (2FN)

Se eliminaron dependencias parciales y se separaron las entidades relacionadas.

![Segunda Forma Normal](docs/img/2FN.png)

### Nuevas entidades

- Rol
- Tipo Consumo
- Unidad Medida
- Proveedor-Insumo
- Compra-Insumo
- Detalle Compra
- Pizza-Tamaño
- Detalle Pedido
- Método Pago
- Pago

---

## Tercera Forma Normal (3FN)

Se eliminaron dependencias transitivas y se agregaron nuevas entidades para mejorar la integridad de los datos.

![Tercera Forma Normal](docs/img/3FN.png)

### Nuevas entidades

- Bebida
- Tipo Bebida
- Bebida Tamaño
- Datos Fiscales
- Factura
- Factura Detalle
- Detalle Bebida
- Cancelación Pedido
- Cancelación Factura

---

## Tablas de Cancelación

![Cancelaciones](docs/img/Cancelaciones.png)