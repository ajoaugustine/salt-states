{% for username, user in pillar['users'].iteritems() %}
{{ username }}:
  user.present:
    - fullname: {{ user['full_name'] }}
    - shell: {{ user['shell'] }}
    - home: {{ user['home'] }}
    - password: {{ user['password'] }}
    {% if user.get('groups', []) %}
    - groups:
      {% for grp in user['groups'] %}
      - {{ grp }}
      {% endfor %}
    {% endif %}
  ssh_auth.present:
    - user: {{ username }} 
    - comment: {{ user['email'] }}
    - enc: {{ user['ssh_key_type'] }}
    - names:
      - {{ user['ssh_key'] }}
    - require:
      - user: {{ username }}
{% endfor %}
