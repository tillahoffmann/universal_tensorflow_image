import tensorflow as tf


# Build a trivial graph
with tf.Graph().as_default() as graph:
    a = tf.placeholder(tf.float32, tuple())
    b = tf.placeholder(tf.float32, tuple())
    c = a + b


# Check the calculation succeeds
config = tf.ConfigProto(log_device_placement=True)
with tf.Session(graph=graph, config=config) as sess:
    assert sess.run(c, {a: 1, b: 2}) == 3
