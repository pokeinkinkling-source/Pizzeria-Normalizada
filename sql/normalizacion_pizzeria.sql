CREATE DATABASE PizzeriaDB;
GO

USE PizzeriaDB;
GO

-- =========================
-- TABLAS CATALOGO
-- =========================

CREATE TABLE Rol (
    id_rol INT IDENTITY(1,1) PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
);

CREATE TABLE TipoConsumo (
    id_tipo_consumo INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE MetodoPago (
    id_metodo_pago INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE UnidadMedida (
    id_unidad_medida INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE Tamano (
    id_tamano INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE TipoBebida (
    id_tipo_bebida INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

-- =========================
-- CLIENTES Y EMPLEADOS
-- =========================

CREATE TABLE Cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    telefono VARCHAR(20),
    direccion VARCHAR(150)
);

CREATE TABLE Empleado (
    id_empleado INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    telefono VARCHAR(20),
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- =========================
-- PRODUCTOS
-- =========================

CREATE TABLE Pizza (
    id_pizza INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE PizzaTamano (
    id_pizza_tamano INT IDENTITY(1,1) PRIMARY KEY,
    id_pizza INT,
    id_tamano INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (id_pizza) REFERENCES Pizza(id_pizza),
    FOREIGN KEY (id_tamano) REFERENCES Tamano(id_tamano)
);

CREATE TABLE Bebida (
    id_bebida INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    id_tipo_bebida INT,
    FOREIGN KEY (id_tipo_bebida) REFERENCES TipoBebida(id_tipo_bebida)
);

CREATE TABLE BebidaTamano (
    id_bebida_tamano INT IDENTITY(1,1) PRIMARY KEY,
    id_bebida INT,
    id_tamano INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (id_bebida) REFERENCES Bebida(id_bebida),
    FOREIGN KEY (id_tamano) REFERENCES Tamano(id_tamano)
);

-- =========================
-- PEDIDOS
-- =========================

CREATE TABLE Pedido (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATETIME,
    id_cliente INT,
    id_empleado INT,
    id_tipo_consumo INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_tipo_consumo) REFERENCES TipoConsumo(id_tipo_consumo)
);

CREATE TABLE DetallePedido (
    id_detalle_pedido INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT,
    id_pizza_tamano INT,
    cantidad INT,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_pizza_tamano) REFERENCES PizzaTamano(id_pizza_tamano)
);

CREATE TABLE DetallePedidoBebida (
    id_detalle_bebida INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT,
    id_bebida_tamano INT,
    cantidad INT,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_bebida_tamano) REFERENCES BebidaTamano(id_bebida_tamano)
);

-- =========================
-- PAGOS Y FACTURAS
-- =========================

CREATE TABLE Pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT,
    id_metodo_pago INT,
    fecha_pago DATETIME,
    monto DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_metodo_pago) REFERENCES MetodoPago(id_metodo_pago)
);

CREATE TABLE Factura (
    id_factura INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATETIME,
    id_cliente INT,
    id_pedido INT,
    id_metodo_pago INT,
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_metodo_pago) REFERENCES MetodoPago(id_metodo_pago)
);

CREATE TABLE DatosFiscales (
    id_datos_fiscales INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    rfc VARCHAR(20),
    razon_social VARCHAR(100),
    uso_cfdi VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE FacturaDetalle (
    id_detalle_factura INT IDENTITY(1,1) PRIMARY KEY,
    id_factura INT,
    concepto VARCHAR(150),
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_factura) REFERENCES Factura(id_factura)
);

-- =========================
-- PROVEEDORES E INSUMOS
-- =========================

CREATE TABLE Proveedor (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Insumo (
    id_insumo INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    id_unidad_medida INT,
    FOREIGN KEY (id_unidad_medida) REFERENCES UnidadMedida(id_unidad_medida)
);

CREATE TABLE ProveedorInsumo (
    id_proveedor_insumo INT IDENTITY(1,1) PRIMARY KEY,
    id_proveedor INT,
    id_insumo INT,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
    FOREIGN KEY (id_insumo) REFERENCES Insumo(id_insumo)
);

CREATE TABLE CompraInsumo (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATETIME,
    id_proveedor INT,
    id_empleado INT,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE DetalleCompra (
    id_detalle_compra INT IDENTITY(1,1) PRIMARY KEY,
    id_compra INT,
    id_insumo INT,
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_compra) REFERENCES CompraInsumo(id_compra),
    FOREIGN KEY (id_insumo) REFERENCES Insumo(id_insumo)
);