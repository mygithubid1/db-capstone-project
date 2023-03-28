from inspect import ismethod


def print_environment_info(client=None):
    from mysql.connector.version import VERSION_TEXT
    print(f'Connector version: {VERSION_TEXT}')
    if hasattr(client, 'pool_name'):
        with client.get_connection() as connection:
            print(f'Server version = {connection.get_server_info()}')
        print(f'Pool name: {client.pool_name}')
        print(f'Pool size: {client.pool_size}')
    if hasattr(client, 'get_server_version') and ismethod(client.get_server_version):
        print(f'Server version: {client.get_server_info()}')


def call_procedure(proc_name, cursor, *args):
    cursor.callproc(proc_name, *args)
    dataset = next(cursor.stored_results())
    print(' - '.join(dataset.column_names))
    for row in dataset:
        print(' - '.join([str(column) for column in row]))


def get_default_connection_config(database=None):
    config = {"user": "root", "password": "password"}
    if database is not None:
        config["database"] = database
    return config


def get_default_database():
    return 'LittleLemonDB'


def print_rows(title, cursor, query, print_columns=True, get_rows=None, print_row=None):
    print(title)
    print('-' * len(title))
    cursor.execute(query)
    if print_columns:
        print(' - '.join(cursor.column_names))
    iterable = get_rows(cursor) if get_rows is not None else cursor.fetchall()
    for row in iterable:
        if print_row is not None:
            print_row(row)
        else:
            print(' - '.join([str(column) for column in row]))